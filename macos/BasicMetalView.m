#import "BasicMetalView.h"
#import <CoreVideo/CoreVideo.h>


////////////////////////////////////////////////////////////////////////////////
@interface BasicMetalNotificationListener : NSObject
@property (nullable, nonatomic, weak) id<NSObject> observer;
@property (nullable, nonatomic, strong) NSArray<id<MTLDevice>> *availableDevices;
+ (instancetype _Nonnull)sharedListener;
+ (id <MTLDevice> _Nullable)defaultDevice;
- (NSArray<id<MTLDevice>>* _Nullable)safeAvailableDevices;
@end
////////////////////////////////////////////////////////////////////////////////
@implementation BasicMetalNotificationListener
+ (instancetype _Nonnull)sharedListener {
    static BasicMetalNotificationListener *shared = nil;
    MTLDeviceNotificationHandler handler = ^(id<MTLDevice> device, MTLDeviceNotificationName notifyName) {
        shared.availableDevices = MTLCopyAllDevices();
    };
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[BasicMetalNotificationListener alloc] init];
        id<NSObject> localObserver = nil;
        shared.availableDevices = MTLCopyAllDevicesWithObserver(&localObserver, handler);
        shared.observer = localObserver;
    });
    return shared;
}
+ (id <MTLDevice> _Nullable)defaultDevice {
    return MTLCreateSystemDefaultDevice();
}
- (NSArray<id<MTLDevice>>* _Nullable)safeAvailableDevices {
    if ([NSThread isMainThread]) {
        return [self.availableDevices copy];
    }
    else {
        __weak BasicMetalNotificationListener *wSelf = self;
        __block NSArray<id<MTLDevice>> *devices = nil;
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        void (^copy_devices)(void) = ^(void) {
            devices = [wSelf.availableDevices copy];
            dispatch_semaphore_signal(sema);
        };
        dispatch_async(dispatch_get_main_queue(), copy_devices);
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        return devices;
    }
}
@end
////////////////////////////////////////////////////////////////////////////////
@interface BasicMetalView () {
    CVDisplayLinkRef displayLink_;
}
@property (nullable, nonatomic, strong) id<MTLDevice> device;
@property (nullable, nonatomic, strong) id<MTLCommandQueue> commandQ;
@property (nullable, nonatomic, strong) CAMetalLayer *metalLayer;
@property (nullable, nonatomic, assign) BasicMetalViewUpdateCallback updateCallback;
@property (nullable, nonatomic, assign) void *updateUserData;
+ (id _Nonnull)layerClass;
@end
////////////////////////////////////////////////////////////////////////////////
static CVReturn BasicMetalViewCVDisplayLinkOutputCallback(CVDisplayLinkRef displayLink,
                                                          const CVTimeStamp *inNow,
                                                          const CVTimeStamp *inOutputTime,
                                                          CVOptionFlags flagsIn,
                                                          CVOptionFlags *flagsOut,
                                                          void *displayLinkContext) {
    BasicMetalView *me = (__bridge BasicMetalView*)displayLinkContext;
    if (me.updateCallback) {
        me.updateCallback(inOutputTime, me.updateUserData);
    }
    return kCVReturnSuccess;
}
////////////////////////////////////////////////////////////////////////////////
@implementation BasicMetalView

+ (id <MTLDevice> _Nullable)defaultMetalDevice {
    return [BasicMetalNotificationListener defaultDevice];
}

+ (NSArray<id<MTLDevice>>* _Nullable)allAvailableMetalDevices {
    return [[BasicMetalNotificationListener sharedListener] safeAvailableDevices];
}

+ (id _Nonnull)layerClass {
    return [CAMetalLayer class];
}

- (instancetype _Nonnull)initWithFrame:(NSRect)frameRect
                             mtlDevice:(id<MTLDevice> _Nonnull)mtlDevice {
    self = [super initWithFrame:frameRect];
    if (self != nil) {
        _device = mtlDevice;
        _commandQ = [_device newCommandQueue];

        self.wantsLayer = YES;
        _metalLayer = [CAMetalLayer layer];
        [_metalLayer setDevice:mtlDevice];
        [_metalLayer setPixelFormat:MTLPixelFormatBGRA8Unorm];
        [_metalLayer setFrame:self.layer.frame];
        _metalLayer.framebufferOnly = YES;
        [self.layer addSublayer:_metalLayer];
    }
    return self;
}

- (void)dealloc {
    if (displayLink_) {
        [self stopRendering];
    }
    _metalLayer = nil;
    _commandQ = nil;
    _device = nil;
}

- (void)resizeMetalSubLayer {
    [_metalLayer setFrame:self.layer.frame];
}

- (NSError * _Nullable)startRenderingWithCallback:(BasicMetalViewUpdateCallback _Nonnull)callback userData:(void * _Nullable)userData {
    [self stopRendering];
    __block NSError *nsErr = nil;
    __block BasicMetalView *bSelf = self;
    __block CVDisplayLinkRef bDisplayLink = nil;
    __block dispatch_semaphore_t sema = nil;
    void(^startRenderingBlock)(void) = ^{
        CVReturn err = CVDisplayLinkCreateWithActiveCGDisplays(&bDisplayLink);
        if (err != kCVReturnSuccess) {
            NSDictionary *info = @{
                NSLocalizedDescriptionKey:@"CVDisplayLinkCreateWithActiveCGDisplays failed."
            };
            nsErr = [NSError errorWithDomain:@"BasicMetalView" code:err userInfo:info];
            bSelf = nil;
            bDisplayLink = nil;
            if (sema) {
                dispatch_semaphore_signal(sema);
            }
            return;
        };
        err = CVDisplayLinkSetOutputCallback(bDisplayLink, BasicMetalViewCVDisplayLinkOutputCallback, (__bridge void*)bSelf);
        if (err != kCVReturnSuccess) {
            NSDictionary *info = @{
                NSLocalizedDescriptionKey:@"CVDisplayLinkSetOutputCallback failed."
            };
            nsErr = [NSError errorWithDomain:@"BasicMetalView" code:err userInfo:info];
            bSelf = nil;
            CVDisplayLinkRelease(bDisplayLink);
            bDisplayLink = nil;
            if (sema) {
                dispatch_semaphore_signal(sema);
            }
            return;
        };
        bSelf.updateCallback = callback;
        bSelf.updateUserData = userData;
        err = CVDisplayLinkStart(bDisplayLink);
        if (err != kCVReturnSuccess) {
            NSDictionary *info = @{
                NSLocalizedDescriptionKey:@"CVDisplayLinkSetOutputCallback failed."
            };
            nsErr = [NSError errorWithDomain:@"BasicMetalView" code:err userInfo:info];
            bSelf.updateCallback = nil;
            bSelf.updateUserData = nil;
            bSelf = nil;
            CVDisplayLinkRelease(bDisplayLink);
            bDisplayLink = nil;
            if (sema) {
                dispatch_semaphore_signal(sema);
            }
            return;
        };
        bSelf = nil;
        if (sema) {
            dispatch_semaphore_signal(sema);
        }
    };
    if ([NSThread isMainThread]) {
        startRenderingBlock();
    }
    else {
        sema = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_main_queue(), startRenderingBlock);
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        sema = nil;
    }
    if (bDisplayLink) {
        @synchronized(self) {
            displayLink_ = bDisplayLink;
        }
        bDisplayLink = nil;
    }
    else if (bDisplayLink == NULL && nsErr == nil) {
        // If bDisplayLink is NULL, nsErr should always be set.
        // If here, something has gone wrong.
        NSDictionary *info = @{
            NSLocalizedDescriptionKey:@"bDisplayLink == NULL && nsErr == nil."
        };
        nsErr = [NSError errorWithDomain:@"BasicMetalView" code:-1 userInfo:info];
    }
    return nsErr;
}

- (NSError * _Nullable)stopRendering {
    __block BasicMetalView *bSelf = self;
    __block CVDisplayLinkRef bDisplayLink = NULL;
    __block dispatch_semaphore_t sema = nil;
    @synchronized(self) {
        bDisplayLink = displayLink_;
        displayLink_ = NULL;
    }
    void(^stopRenderingBlock)(void) = ^{
        if (bDisplayLink) {
            CVDisplayLinkStop(bDisplayLink);
            bDisplayLink = NULL;
        }
        bSelf.updateCallback = nil;
        bSelf.updateUserData = nil;
        bSelf = nil;
        if (sema) {
            dispatch_semaphore_signal(sema);
        }
    };
    if ([NSThread isMainThread]) {
        stopRenderingBlock();
    }
    else {
        sema = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_main_queue(), stopRenderingBlock);
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        sema = nil;
    }
    return nil;
}
@end
////////////////////////////////////////////////////////////////////////////////

#import <Cocoa/Cocoa.h>
#import <Metal/Metal.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(*BasicMetalViewUpdateCallback)(const CVTimeStamp *currentTime, void *userData);

@interface BasicMetalView : NSView
@property (nullable, nonatomic, readonly) id<MTLDevice> device;
@property (nullable, nonatomic, readonly) id<MTLCommandQueue> commandQ;
@property (nullable, nonatomic, readonly) CAMetalLayer *metalLayer;

+ (id <MTLDevice> _Nullable)defaultMetalDevice;
+ (NSArray<id<MTLDevice>>* _Nullable)allAvailableMetalDevices;
- (instancetype _Nonnull)initWithFrame:(NSRect)frameRect
                             mtlDevice:(id<MTLDevice> _Nonnull)mtlDevice;
- (void)resizeMetalSubLayer;
- (NSError * _Nullable)startRenderingWithCallback:(BasicMetalViewUpdateCallback _Nonnull)callback userData:(void * _Nullable)userData;
- (NSError * _Nullable)stopRendering;
@end

NS_ASSUME_NONNULL_END

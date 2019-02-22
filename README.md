# Basic Windows

## What is this?

`TODO`

## macOS

### Creating a basic window in a console application.

```
#import <Cocoa/Cocoa.h>
#import "BasicWindow.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CGFloat x, y, width, height;
        // Create your own NSViewController.
        NSViewController *vc = [[NSViewController alloc] initWithNibName:nil bundle:nil];
        IBasicWindowDelegateCallbacks window_delegate_cbs = {0};
        BasicWindowDelegate *window_delegate = [[BasicWindowDelegate alloc] initWithCallbacks:&window_delegate_cbs];
        NSWindow *window = [BasicWindowFactory windowWithContentViewController:vc windowDelegate:window_delegate];
        [window setFrame:NSMakeRect(x, y, width, height) display:YES];
        NSWindowController *window_controller = [[NSWindowController alloc] initWithWindow:window];
        IBasicApplicationDelegateCallbacks app_delegate_cbs = {0};
        app_delegate_cbs.user_data = (__bridge void*)window_controller;
        app_delegate_cbs.application_did_finish_launching = [](NSNotification * _Nullable notification, void * _Nullable user_data) {
            NSWindowController *window_controller = (__bridge NSWindowController*)user_data;
            [window_controller showWindow:nil];
        };
        BasicApplicationDelegate *app_delegate = [[BasicApplicationDelegate alloc] initWithCallbacks:&app_delegate_cbs];
        [[NSApplication sharedApplication] setDelegate:app_delegate];
        [[NSApplication sharedApplication] run];
    }
    return 0;
}
```

### Creating a basic Metal view

`TODO`

## Windows

### Creating a basic window

`TODO`

### Creating a basic DX12 window

`TODO`

### Creating a basic Vulkan window

`TODO`



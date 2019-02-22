#import "BasicWindow.h"
////////////////////////////////////////////////////////////////////////////////
@implementation BasicApplicationDelegate

- (instancetype _Nonnull)initWithCallbacks:(const IBasicApplicationDelegateCallbacks * _Nonnull)callbacks {
    self = [super init];
    if (self != nil) {
        memcpy(&callbacks_, callbacks, sizeof(IBasicApplicationDelegateCallbacks));
    }
    return self;
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
    if (callbacks_.application_will_finish_launching) {
        callbacks_.application_will_finish_launching(notification, callbacks_.user_data);
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    if (callbacks_.application_did_finish_launching) {
        callbacks_.application_did_finish_launching(notification, callbacks_.user_data);
    }
}

- (void)applicationWillBecomeActive:(NSNotification *)notification {
    if (callbacks_.application_will_become_active) {
        callbacks_.application_will_become_active(notification, callbacks_.user_data);
    }
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    if (callbacks_.application_did_become_active) {
        callbacks_.application_did_become_active(notification, callbacks_.user_data);
    }
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    if (callbacks_.application_will_resign_active) {
        callbacks_.application_will_resign_active(notification, callbacks_.user_data);
    }
}

- (void)applicationDidResignActive:(NSNotification *)notification {
    if (callbacks_.application_did_resign_active) {
        callbacks_.application_did_resign_active(notification, callbacks_.user_data);
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    if (callbacks_.application_should_terminate) {
        return callbacks_.application_should_terminate(sender, callbacks_.user_data);
    }
    return NSTerminateNow;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    if (callbacks_.application_should_terminate_after_last_window_closed) {
        return callbacks_.application_should_terminate_after_last_window_closed(sender, callbacks_.user_data);
    }
    return NO;
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    if (callbacks_.application_will_terminate) {
        callbacks_.application_will_terminate(notification, callbacks_.user_data);
    }
}

- (void)applicationWillHide:(NSNotification *)notification {
    if (callbacks_.application_will_hide) {
        callbacks_.application_will_hide(notification, callbacks_.user_data);
    }
}

- (void)applicationDidHide:(NSNotification *)notification {
    if (callbacks_.application_did_hide) {
        callbacks_.application_did_hide(notification, callbacks_.user_data);
    }
}

- (void)applicationWillUnhide:(NSNotification *)notification {
    if (callbacks_.application_will_unhide) {
        callbacks_.application_will_unhide(notification, callbacks_.user_data);
    }
}

- (void)applicationDidUnhide:(NSNotification *)notification {
    if (callbacks_.application_did_unhide) {
        callbacks_.application_did_unhide(notification, callbacks_.user_data);
    }
}

- (void)applicationWillUpdate:(NSNotification *)notification {
    if (callbacks_.application_will_update) {
        callbacks_.application_will_update(notification, callbacks_.user_data);
    }
}

- (void)applicationDidUpdate:(NSNotification *)notification {
    if (callbacks_.application_did_update) {
        callbacks_.application_did_update(notification, callbacks_.user_data);
    }
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    if (callbacks_.application_should_handle_reopen) {
        return callbacks_.application_should_handle_reopen(sender, flag, callbacks_.user_data);
    }
    return NO;
}

- (NSMenu * _Nullable)applicationDockMenu:(NSApplication *)sender {
    if (callbacks_.application_dock_menu) {
        return callbacks_.application_dock_menu(sender, callbacks_.user_data);
    }
    return nil;
}

- (NSError *)application:(NSApplication *)application willPresentError:(NSError *)error {
    if (callbacks_.application_will_present_error) {
        return callbacks_.application_will_present_error(application, error, callbacks_.user_data);
    }
    return error;
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification {
    if (callbacks_.application_did_change_screen_parameters) {
        callbacks_.application_did_change_screen_parameters(notification, callbacks_.user_data);
    }
}

- (BOOL)application:(NSApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    if (callbacks_.application_will_continue_user_activity_with_type) {
        return callbacks_.application_will_continue_user_activity_with_type(application, userActivityType, callbacks_.user_data);
    }
    return NO;
}

- (BOOL)application:(NSApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<NSUserActivityRestoring>> * _Nonnull))restorationHandler {
    if (callbacks_.application_continue_user_activity_restoration_handler) {
        return callbacks_.application_continue_user_activity_restoration_handler(application, userActivity, restorationHandler, callbacks_.user_data);
    }
    return NO;
}

- (void)application:(NSApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    if (callbacks_.application_did_fail_to_continue_user_activity_with_type_error) {
        callbacks_.application_did_fail_to_continue_user_activity_with_type_error(application, userActivityType, error, callbacks_.user_data);
    }
}

- (void)application:(NSApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    if (callbacks_.application_did_update_user_activity) {
        callbacks_.application_did_update_user_activity(application, userActivity, callbacks_.user_data);
    }
}

- (void)application:(NSApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if (callbacks_.application_did_register_for_remote_notifications_with_device_token) {
        callbacks_.application_did_register_for_remote_notifications_with_device_token(application, deviceToken, callbacks_.user_data);
    }
}

- (void)application:(NSApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (callbacks_.application_did_fail_to_register_for_remote_notifications_with_error) {
        callbacks_.application_did_fail_to_register_for_remote_notifications_with_error(application, error, callbacks_.user_data);
    }
}

- (void)application:(NSApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary<NSString *,id> *)userInfo {
    if (callbacks_.application_did_receive_remote_notification) {
        callbacks_.application_did_receive_remote_notification(application, userInfo, callbacks_.user_data);
    }
}

- (void)application:(NSApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)metadata {
    if (callbacks_.application_user_did_accept_cloud_kit_share_with_metadata) {
        callbacks_.application_user_did_accept_cloud_kit_share_with_metadata(application, metadata, callbacks_.user_data);
    }
}

- (void)application:(NSApplication *)application openURLs:(nonnull NSArray<NSURL *> *)urls {
    if (callbacks_.application_open_urls) {
        callbacks_.application_open_urls(application, urls, callbacks_.user_data);
    }
}

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename {
    if (callbacks_.application_open_file) {
        return callbacks_.application_open_file(sender, filename, callbacks_.user_data);
    }
    return NO;
}

- (BOOL)application:(id)sender openFileWithoutUI:(NSString *)filename {
    if (callbacks_.application_open_file_without_ui) {
        return callbacks_.application_open_file_without_ui(sender, filename, callbacks_.user_data);
    }
    return NO;
}

- (BOOL)application:(NSApplication *)sender openTempFile:(NSString *)filename {
    if (callbacks_.application_open_temp_file) {
        return callbacks_.application_open_temp_file(sender, filename, callbacks_.user_data);
    }
    return NO;
}

- (void)application:(NSApplication *)sender openFiles:(NSArray<NSString *> *)filenames {
    if (callbacks_.application_open_files) {
        callbacks_.application_open_files(sender, filenames, callbacks_.user_data);
    }
}

- (BOOL)applicationOpenUntitledFile:(NSApplication *)sender {
    if (callbacks_.application_open_untitled_file) {
        return callbacks_.application_open_untitled_file(sender, callbacks_.user_data);
    }
    return NO;
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender {
    if (callbacks_.application_should_open_untitled_file) {
        return callbacks_.application_should_open_untitled_file(sender, callbacks_.user_data);
    }
    return NO;
}

- (BOOL)application:(NSApplication *)sender printFile:(NSString *)filename {
    if (callbacks_.application_print_file) {
        return callbacks_.application_print_file(sender, filename, callbacks_.user_data);
    }
    return NO;
}

- (NSApplicationPrintReply)application:(NSApplication *)application printFiles:(NSArray<NSString *> *)fileNames withSettings:(NSDictionary<NSPrintInfoAttributeKey,id> *)printSettings showPrintPanels:(BOOL)showPrintPanels {
    if (callbacks_.application_print_files_with_settings_show_print_panels) {
        return callbacks_.application_print_files_with_settings_show_print_panels(application, fileNames, printSettings, showPrintPanels, callbacks_.user_data);
    }
    return NSPrintingReplyLater;
}

- (void)application:(NSApplication *)app didDecodeRestorableState:(NSCoder *)coder {
    if (callbacks_.application_did_decode_restorable_state) {
        callbacks_.application_did_decode_restorable_state(app, coder, callbacks_.user_data);
    }
}

- (void)application:(NSApplication *)app willEncodeRestorableState:(NSCoder *)coder {
    if (callbacks_.application_will_encode_restorable_state) {
        callbacks_.application_will_encode_restorable_state(app, coder, callbacks_.user_data);
    }
}

- (void)applicationDidChangeOcclusionState:(NSNotification *)notification {
    if (callbacks_.application_did_change_occlusion_state) {
        callbacks_.application_did_change_occlusion_state(notification, callbacks_.user_data);
    }
}

@end
////////////////////////////////////////////////////////////////////////////////
@implementation BasicWindowDelegate

- (instancetype _Nonnull)initWithCallbacks:(const IBasicWindowDelegateCallbacks * _Nonnull)callbacks {
    self = [super init];
    if (self != nil) {
        memcpy(&callbacks_, callbacks, sizeof(IBasicWindowDelegateCallbacks));
    }
    return self;
}

- (NSRect)window:(NSWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect {
    if (callbacks_.window_will_position_sheet_using_rect) {
        return callbacks_.window_will_position_sheet_using_rect(window, sheet, rect, callbacks_.user_data);
    }
    return rect;
}

-(void)windowWillBeginSheet:(NSNotification *)notification {
    if (callbacks_.window_will_begin_sheet) {
        callbacks_.window_will_begin_sheet(notification, callbacks_.user_data);
    }
}

-(void)windowWillEndSheet:(NSNotification *)notification {
    if (callbacks_.window_end_begin_sheet) {
        callbacks_.window_end_begin_sheet(notification, callbacks_.user_data);
    }
}

- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize {
    if (callbacks_.window_will_resize_to_size) {
        return callbacks_.window_will_resize_to_size(sender, frameSize, callbacks_.user_data);
    }
    return frameSize;
}

- (void)windowDidResize:(NSNotification *)notification {
    if (callbacks_.window_did_resize) {
        callbacks_.window_did_resize(notification, callbacks_.user_data);
    }
}

- (void)windowWillStartLiveResize:(NSNotification *)notification {
    if (callbacks_.window_will_start_live_resize) {
        callbacks_.window_will_start_live_resize(notification, callbacks_.user_data);
    }
}

- (void)windowDidEndLiveResize:(NSNotification *)notification {
    if (callbacks_.window_did_end_live_resize) {
        callbacks_.window_did_end_live_resize(notification, callbacks_.user_data);
    }
}

- (void)windowWillMiniaturize:(NSNotification *)notification {
    if (callbacks_.window_will_miniaturize) {
        callbacks_.window_will_miniaturize(notification, callbacks_.user_data);
    }
}

- (void)windowDidMiniaturize:(NSNotification *)notification {
    if (callbacks_.window_did_miniaturize) {
        callbacks_.window_did_miniaturize(notification, callbacks_.user_data);
    }
}

- (void)windowDidDeminiaturize:(NSNotification *)notification {
    if (callbacks_.window_did_deminiaturize) {
        callbacks_.window_did_deminiaturize(notification, callbacks_.user_data);
    }
}

- (NSRect)windowWillUseStandardFrame:(NSWindow *)window defaultFrame:(NSRect)newFrame {
    if (callbacks_.window_will_use_standard_frame) {
        return callbacks_.window_will_use_standard_frame(window, newFrame, callbacks_.user_data);
    }
    return newFrame;
}

- (BOOL)windowShouldZoom:(NSWindow *)window toFrame:(NSRect)newFrame {
    if (callbacks_.window_should_zoom_to_frame) {
        return callbacks_.window_should_zoom_to_frame(window, newFrame, callbacks_.user_data);
    }
    return YES;
}

- (NSSize)window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize {
    if (callbacks_.window_will_use_full_screen_content_size) {
        return callbacks_.window_will_use_full_screen_content_size(window, proposedSize, callbacks_.user_data);
    }
    return proposedSize;
}

- (NSApplicationPresentationOptions)window:(NSWindow *)window willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions {
    if (callbacks_.window_will_use_full_screen_presentation_options) {
        return callbacks_.window_will_use_full_screen_presentation_options(window, proposedOptions, callbacks_.user_data);
    }
    return proposedOptions;
}

- (void)windowWillEnterFullScreen:(NSNotification *)notification {
    if (callbacks_.window_will_enter_full_screen) {
        callbacks_.window_will_enter_full_screen(notification, callbacks_.user_data);
    }
}

- (void)windowDidEnterFullScreen:(NSNotification *)notification {
    if (callbacks_.window_did_enter_full_screen) {
        callbacks_.window_did_enter_full_screen(notification, callbacks_.user_data);
    }
}

- (void)windowWillExitFullScreen:(NSNotification *)notification {
    if (callbacks_.window_will_exit_full_screen) {
        callbacks_.window_will_exit_full_screen(notification, callbacks_.user_data);
    }
}

- (void)windowDidExitFullScreen:(NSNotification *)notification {
    if (callbacks_.window_did_exit_full_screen) {
        callbacks_.window_did_exit_full_screen(notification, callbacks_.user_data);
    }
}

- (NSArray<NSWindow*> * _Nullable)customWindowsToEnterFullScreenForWindow:(NSWindow *)window {
    if (callbacks_.custom_windows_to_enter_full_screen_for_window) {
        return callbacks_.custom_windows_to_enter_full_screen_for_window(window, callbacks_.user_data);
    }
    return nil;
}

- (NSArray<NSWindow*> * _Nullable)customWindowsToEnterFullScreenForWindow:(NSWindow *)window onScreen:(NSScreen *)screen {
    if (callbacks_.custom_windows_to_enter_full_screen_for_window_on_screen) {
        return callbacks_.custom_windows_to_enter_full_screen_for_window_on_screen(window, screen, callbacks_.user_data);
    }
    return nil;
}

- (void)window:(NSWindow *)window startCustomAnimationToEnterFullScreenWithDuration:(NSTimeInterval)duration {
    if (callbacks_.window_start_custom_animation_to_enter_full_screen_with_duration) {
        callbacks_.window_start_custom_animation_to_enter_full_screen_with_duration(window, duration, callbacks_.user_data);
    }
}

- (void)window:(NSWindow *)window startCustomAnimationToEnterFullScreenOnScreen:(NSScreen *)screen withDuration:(NSTimeInterval)duration {
    if (callbacks_.window_start_custom_animation_to_enter_full_screen_on_screen_with_duration) {
        callbacks_.window_start_custom_animation_to_enter_full_screen_on_screen_with_duration(window, screen, duration, callbacks_.user_data);
    }
}

- (void)windowDidFailToEnterFullScreen:(NSWindow *)window {
    if (callbacks_.window_did_fail_to_enter_full_screen) {
        callbacks_.window_did_fail_to_enter_full_screen(window, callbacks_.user_data);
    }
}

- (NSArray<NSWindow*>* _Nullable)customWindowsToExitFullScreenForWindow:(NSWindow *)window {
    if (callbacks_.custom_windows_to_exit_full_screen_for_window) {
        return callbacks_.custom_windows_to_exit_full_screen_for_window(window, callbacks_.user_data);
    }
    return nil;
}

- (void)window:(NSWindow *)window startCustomAnimationToExitFullScreenWithDuration:(NSTimeInterval)duration {
    if (callbacks_.window_start_custom_animation_to_exit_full_screen_with_duration) {
        callbacks_.window_start_custom_animation_to_exit_full_screen_with_duration(window, duration, callbacks_.user_data);
    }
}

- (void)windowDidFailToExitFullScreen:(NSWindow *)window {
    if (callbacks_.window_did_fail_to_exit_full_screen) {
        callbacks_.window_did_fail_to_exit_full_screen(window, callbacks_.user_data);
    }
}

- (void)windowWillMove:(NSNotification *)notification {
    if (callbacks_.window_will_move) {
        callbacks_.window_will_move(notification, callbacks_.user_data);
    }
}

- (void)windowDidMove:(NSNotification *)notification {
    if (callbacks_.window_did_move) {
        callbacks_.window_did_move(notification, callbacks_.user_data);
    }
}

- (void)windowDidChangeScreen:(NSNotification *)notification {
    if (callbacks_.window_did_change_screen) {
        callbacks_.window_did_change_screen(notification, callbacks_.user_data);
    }
}

- (void)windowDidChangeScreenProfile:(NSNotification *)notification {
    if (callbacks_.window_did_change_screen_profile) {
        callbacks_.window_did_change_screen_profile(notification, callbacks_.user_data);
    }
}

- (void)windowDidChangeBackingProperties:(NSNotification *)notification {
    if (callbacks_.window_did_change_backing_properties) {
        callbacks_.window_did_change_backing_properties(notification, callbacks_.user_data);
    }
}

- (BOOL)windowShouldClose:(NSWindow *)sender {
    if (callbacks_.window_should_close) {
        return callbacks_.window_should_close(sender, callbacks_.user_data);
    }
    return NO;
}

- (void)windowWillClose:(NSNotification *)notification {
    if (callbacks_.window_will_close) {
        callbacks_.window_will_close(notification, callbacks_.user_data);
    }
}

- (void)windowDidBecomeKey:(NSNotification *)notification {
    if (callbacks_.window_did_become_key) {
        callbacks_.window_did_become_key(notification, callbacks_.user_data);
    }
}

- (void)windowDidResignKey:(NSNotification *)notification {
    if (callbacks_.window_did_resign_key) {
        callbacks_.window_did_resign_key(notification, callbacks_.user_data);
    }
}

- (void)windowDidBecomeMain:(NSNotification *)notification {
    if (callbacks_.window_did_become_main) {
        callbacks_.window_did_become_main(notification, callbacks_.user_data);
    }
}

- (void)windowDidResignMain:(NSNotification *)notification {
    if (callbacks_.window_did_resign_main) {
        callbacks_.window_did_resign_main(notification, callbacks_.user_data);
    }
}

- (id)windowWillReturnFieldEditor:(NSWindow *)sender toObject:(id)client {
    if (callbacks_.window_will_return_field_editor) {
        return callbacks_.window_will_return_field_editor(sender, client, callbacks_.user_data);
    }
    return nil;
}

- (void)windowDidUpdate:(NSNotification *)notification {
    if (callbacks_.window_did_update) {
        callbacks_.window_did_update(notification, callbacks_.user_data);
    }
}

- (void)windowDidExpose:(NSNotification *)notification {
    if (callbacks_.window_did_expose) {
        callbacks_.window_did_expose(notification, callbacks_.user_data);
    }
}

- (void)windowDidChangeOcclusionState:(NSNotification *)notification {
    if (callbacks_.window_did_change_occlusion_state) {
        callbacks_.window_did_change_occlusion_state(notification, callbacks_.user_data);
    }
}

- (BOOL)window:(NSWindow *)window shouldDragDocumentWithEvent:(NSEvent *)event from:(NSPoint)dragImageLocation withPasteboard:(NSPasteboard *)pasteboard {
    if (callbacks_.window_should_drag_document_with_event_from_drag_image_location_with_pasteboard) {
        return callbacks_.window_should_drag_document_with_event_from_drag_image_location_with_pasteboard(window, event, dragImageLocation, pasteboard, callbacks_.user_data);
    }
    return NO;
}

- (NSUndoManager * _Nullable)windowWillReturnUndoManager:(NSWindow *)window {
    if (callbacks_.window_will_return_undo_manager) {
        return callbacks_.window_will_return_undo_manager(window, callbacks_.user_data);
    }
    return nil;
}

- (BOOL)window:(NSWindow *)window shouldPopUpDocumentPathMenu:(NSMenu *)menu {
    if (callbacks_.window_should_popup_document_path_menu) {
        return callbacks_.window_should_popup_document_path_menu(menu, callbacks_.user_data);
    }
    return NO;
}

- (void)window:(NSWindow *)window willEncodeRestorableState:(NSCoder *)state {
    if (callbacks_.window_will_encode_restorable_state) {
        callbacks_.window_will_encode_restorable_state(window, state, callbacks_.user_data);
    }
}

- (void)window:(NSWindow *)window didDecodeRestorableState:(NSCoder *)state {
    if (callbacks_.window_did_decode_restorable_state) {
        callbacks_.window_did_decode_restorable_state(window, state, callbacks_.user_data);
    }
}

- (NSSize)window:(NSWindow *)window willResizeForVersionBrowserWithMaxPreferredSize:(NSSize)maxPreferredFrameSize maxAllowedSize:(NSSize)maxAllowedFrameSize {
    if (callbacks_.window_will_resize_for_version_browser_with_max_preferred_size_max_allowed_size) {
        return callbacks_.window_will_resize_for_version_browser_with_max_preferred_size_max_allowed_size(window, maxPreferredFrameSize, maxAllowedFrameSize, callbacks_.user_data);
    }
    return maxPreferredFrameSize;
}

- (void)windowWillEnterVersionBrowser:(NSNotification *)notification {
    if (callbacks_.window_will_enter_version_browser) {
        callbacks_.window_will_enter_version_browser(notification, callbacks_.user_data);
    }
}

- (void)windowDidEnterVersionBrowser:(NSNotification *)notification {
    if (callbacks_.window_did_enter_version_browser) {
        callbacks_.window_did_enter_version_browser(notification, callbacks_.user_data);
    }
}

- (void)windowWillExitVersionBrowser:(NSNotification *)notification {
    if (callbacks_.window_will_exit_version_browser) {
        callbacks_.window_will_exit_version_browser(notification, callbacks_.user_data);
    }
}

- (void)windowDidExitVersionBrowser:(NSNotification *)notification {
    if (callbacks_.window_did_exit_version_browser) {
        callbacks_.window_did_exit_version_browser(notification, callbacks_.user_data);
    }
}
 
@end
////////////////////////////////////////////////////////////////////////////////
@implementation BasicWindowFactory
+ (NSWindow * _Nonnull)windowWithContentViewController:(NSViewController * _Nonnull)contentViewController windowDelegate:(BasicWindowDelegate * _Nonnull)windowDelegate {
    NSWindow *window = [NSWindow windowWithContentViewController:contentViewController];
    window.delegate = windowDelegate;
    return window;
}
@end

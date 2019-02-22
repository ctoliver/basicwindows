#import <Cocoa/Cocoa.h>
////////////////////////////////////////////////////////////////////////////////
NS_ASSUME_NONNULL_BEGIN
////////////////////////////////////////////////////////////////////////////////
typedef void(^IBasicApplicationDelegateCallbacksRestorationHandler)(NSArray<id<NSUserActivityRestoring>> *restorableObjects);
////////////////////////////////////////////////////////////////////////////////
typedef struct IBasicApplicationDelegateCallbacks {
    // Launching applications
    void(*application_will_finish_launching)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*application_did_finish_launching)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Managing active status
    void(*application_will_become_active)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*application_did_become_active)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*application_will_resign_active)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*application_did_resign_active)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Terminating applications
    NSApplicationTerminateReply(*application_should_terminate)(NSApplication * _Nullable sender, void * _Nullable user_data); // NSTerminateNow
    BOOL(*application_should_terminate_after_last_window_closed)(NSApplication * _Nullable sender, void * _Nullable user_data); // NO
    void(*application_will_terminate)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Hiding applications
    void(*application_will_hide)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*application_did_hide)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*application_will_unhide)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*application_did_unhide)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Managing windows
    void(*application_will_update)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*application_did_update)(NSNotification * _Nullable notification, void * _Nullable user_data);
    BOOL(*application_should_handle_reopen)(NSApplication * _Nullable sender, BOOL hasVisibleWindowsFlag, void * _Nullable user_data); // NO
    // Managing the dock menu
    NSMenu * _Nullable(* _Nullable application_dock_menu)(NSApplication * _Nullable sender, void * _Nullable user_data);
    // Displaying errors
    NSError * _Nonnull(* _Nullable application_will_present_error)(NSApplication * _Nullable sender, NSError * _Nonnull error, void * _Nullable user_data);
    // Managing the screen
    void(*application_did_change_screen_parameters)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Continuing user activities
    BOOL(*application_will_continue_user_activity_with_type)(NSApplication * _Nullable application, NSString * _Nullable user_activity_type, void * _Nullable user_data);
    BOOL(*application_continue_user_activity_restoration_handler)(NSApplication * _Nullable application, NSUserActivity * _Nullable, IBasicApplicationDelegateCallbacksRestorationHandler _Nullable restoration_handler, void * _Nullable user_data);
    void(*application_did_fail_to_continue_user_activity_with_type_error)(NSApplication * _Nullable application, NSString * _Nullable user_activity_type, NSError * _Nullable error, void * _Nullable user_data);
    void(*application_did_update_user_activity)(NSApplication * _Nullable application, NSUserActivity * _Nullable user_activity, void * _Nullable user_data);
    // Handling push notifications
    void(*application_did_register_for_remote_notifications_with_device_token)(NSApplication * _Nullable application, NSData * _Nullable device_token, void * _Nullable user_data);
    void(*application_did_fail_to_register_for_remote_notifications_with_error)(NSApplication * _Nullable application, NSError * _Nullable error, void * _Nullable user_data);
    void(*application_did_receive_remote_notification)(NSApplication * _Nullable application, NSDictionary<NSString*, id> * _Nullable user_info, void * _Nullable user_data);
    // Handling CloudKit invitations
    void(*application_user_did_accept_cloud_kit_share_with_metadata)(NSApplication * _Nullable application, CKShareMetadata * _Nullable metadata, void * _Nullable user_data);
    // Opening files
    void(*application_open_urls)(NSApplication * _Nullable application, NSArray<NSURL*> * _Nullable open_urls, void * _Nullable user_data);
    BOOL(*application_open_file)(NSApplication * _Nullable sender, NSString * _Nullable filename, void * _Nullable user_data);
    BOOL(*application_open_file_without_ui)(id _Nullable sender, NSString * _Nullable filename, void * _Nullable user_data);
    BOOL(*application_open_temp_file)(NSApplication * _Nullable sender, NSString * _Nullable filename, void * _Nullable user_data);
    void(*application_open_files)(NSApplication * _Nullable sender, NSArray<NSString*> * _Nullable filenames, void * _Nullable user_data);
    BOOL(*application_open_untitled_file)(NSApplication * _Nullable sender, void * _Nullable user_data);
    BOOL(*application_should_open_untitled_file)(NSApplication * _Nullable sender, void * _Nullable user_data);
    // Printing
    BOOL(*application_print_file)(NSApplication * _Nullable sender, NSString * _Nullable filename, void * _Nullable user_data);
    NSApplicationPrintReply(*application_print_files_with_settings_show_print_panels)(NSApplication * _Nullable application, NSArray<NSString*> * _Nullable filenames, NSDictionary<NSPrintInfoAttributeKey, id> * _Nullable print_settings, BOOL show_print_panels, void * _Nullable user_data);
    // Restoring application state
    void(*application_did_decode_restorable_state)(NSApplication * _Nullable app, NSCoder * _Nullable coder, void * _Nullable user_data);
    void(*application_will_encode_restorable_state)(NSApplication * _Nullable app, NSCoder * _Nullable coder, void * _Nullable user_data);
    // Handling changes to the occlusion state
    void(*application_did_change_occlusion_state)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void *user_data;
}IBasicApplicationDelegateCallbacks;
////////////////////////////////////////////////////////////////////////////////
typedef struct IBasicWindowDelegateCallbacks {
    // Managing sheets
    NSRect(*window_will_position_sheet_using_rect)(NSWindow * _Nullable window, NSWindow * _Nullable sheet, NSRect rect, void * _Nullable user_data);
    void(*window_will_begin_sheet)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_end_begin_sheet)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Sizing windows
    NSSize(*window_will_resize_to_size)(NSWindow * _Nullable sender, NSSize frame_size, void * _Nullable user_data);
    void(*window_did_resize)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_will_start_live_resize)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_end_live_resize)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Minimizing windows
    void(*window_will_miniaturize)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_miniaturize)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_deminiaturize)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Zooming window
    NSRect(*window_will_use_standard_frame)(NSWindow * _Nullable window, NSRect default_frame, void * _Nullable user_data);
    BOOL(*window_should_zoom_to_frame)(NSWindow * _Nullable window, NSRect new_frame, void * _Nullable user_data);
    // Managing full-screen presentation
    NSSize(*window_will_use_full_screen_content_size)(NSWindow * _Nullable window, NSSize proposed_size, void * _Nullable user_data);
    NSApplicationPresentationOptions(*window_will_use_full_screen_presentation_options)(NSWindow * _Nullable window, NSApplicationPresentationOptions proposed_options, void * _Nullable user_data);
    void(*window_will_enter_full_screen)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_enter_full_screen)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_will_exit_full_screen)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_exit_full_screen)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Custom full-screen presentation animations
    NSArray<NSWindow*>* _Nullable(* _Nullable custom_windows_to_enter_full_screen_for_window)(NSWindow * _Nullable window, void * _Nullable user_data);
    NSArray<NSWindow*>* _Nullable(* _Nullable custom_windows_to_enter_full_screen_for_window_on_screen)(NSWindow * _Nullable window, NSScreen * _Nullable screen, void * _Nullable user_data);
    void(*window_start_custom_animation_to_enter_full_screen_with_duration)(NSWindow * _Nullable window, NSTimeInterval duration, void * _Nullable user_data);
    void(*window_start_custom_animation_to_enter_full_screen_on_screen_with_duration)(NSWindow * _Nullable window, NSScreen * _Nullable screen, NSTimeInterval duration, void * _Nullable user_data);
    void(*window_did_fail_to_enter_full_screen)(NSWindow * _Nullable window, void * _Nullable user_data);
    NSArray<NSWindow*>* _Nullable(* _Nullable custom_windows_to_exit_full_screen_for_window)(NSWindow * _Nullable window, void * _Nullable user_data);
    void(*window_start_custom_animation_to_exit_full_screen_with_duration)(NSWindow * _Nullable, NSTimeInterval duration, void * _Nullable user_data);
    void(*window_did_fail_to_exit_full_screen)(NSWindow * _Nullable window, void * _Nullable user_data);
    // Moving windows
    void(*window_will_move)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_move)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_change_screen)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_change_screen_profile)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_change_backing_properties)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Closing windows
    BOOL(*window_should_close)(NSWindow * _Nullable sender, void * _Nullable user_data);
    void(*window_will_close)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Managing key status
    void(*window_did_become_key)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_resign_key)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Managing main status
    void(*window_did_become_main)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_resign_main)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Managing field editors
    id _Nullable (* _Nullable window_will_return_field_editor)(NSWindow * _Nullable sender, id _Nullable to_object_client, void * _Nullable user_data);
    // Updating windows
    void(*window_did_update)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Exposing windows
    void(*window_did_expose)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Managing occlusion state
    void(*window_did_change_occlusion_state)(NSNotification * _Nullable notification, void * _Nullable user_data);
    // Dragging windows
    BOOL(*window_should_drag_document_with_event_from_drag_image_location_with_pasteboard)(NSWindow * _Nullable window, NSEvent * _Nullable event, NSPoint draw_image_location, NSPasteboard * _Nullable pasteboard, void * _Nullable user_data);
    // Getting the undo manager
    NSUndoManager * _Nullable(* _Nullable window_will_return_undo_manager)(NSWindow * _Nullable window, void * _Nullable user_data);
    // Managing titles
    BOOL(*window_should_popup_document_path_menu)(NSMenu * _Nullable menu, void * _Nullable user_data);
    // Managing restorable state
    void(*window_will_encode_restorable_state)(NSWindow * _Nullable window, NSCoder * _Nullable state, void * _Nullable user_data);
    void(*window_did_decode_restorable_state)(NSWindow * _Nullable window, NSCoder * _Nullable state, void * _Nullable user_data);
    // Managing presentation in version browsers
    NSSize(*window_will_resize_for_version_browser_with_max_preferred_size_max_allowed_size)(NSWindow * _Nullable window, NSSize max_preferred_frame_size, NSSize max_allowed_frame_size, void * _Nullable user_data);
    void(*window_will_enter_version_browser)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_enter_version_browser)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_will_exit_version_browser)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void(*window_did_exit_version_browser)(NSNotification * _Nullable notification, void * _Nullable user_data);
    void *user_data;
}IBasicWindowDelegateCallbacks;
////////////////////////////////////////////////////////////////////////////////
@interface BasicApplicationDelegate : NSObject <NSApplicationDelegate> {
    IBasicApplicationDelegateCallbacks callbacks_;
}
- (instancetype _Nonnull)initWithCallbacks:(const IBasicApplicationDelegateCallbacks * _Nonnull)callbacks;
@end
////////////////////////////////////////////////////////////////////////////////
@interface BasicWindowDelegate : NSObject <NSWindowDelegate> {
    IBasicWindowDelegateCallbacks callbacks_;
}
- (instancetype _Nonnull)initWithCallbacks:(const IBasicWindowDelegateCallbacks * _Nonnull)callbacks;
@end
////////////////////////////////////////////////////////////////////////////////
@interface BasicWindowFactory : NSObject
+ (NSWindow * _Nonnull)windowWithContentViewController:(NSViewController * _Nonnull)contentViewController windowDelegate:(BasicWindowDelegate * _Nonnull)windowDelegate;
@end
////////////////////////////////////////////////////////////////////////////////
NS_ASSUME_NONNULL_END
////////////////////////////////////////////////////////////////////////////////

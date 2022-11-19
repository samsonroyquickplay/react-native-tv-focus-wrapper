#import <React/RCTViewManager.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(TvFocusWrapperViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(scale, NSString)
RCT_EXPORT_VIEW_PROPERTY(onFocus, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onBlur, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

@end

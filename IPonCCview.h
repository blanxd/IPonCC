#import <UIKit/UIKit.h>
#import <ControlCenterUIKit/CCUIToggleModule.h>

@interface IPonCCview : UIViewController <CCUIContentModuleContentViewController>
@property (nonatomic, assign, readwrite) BOOL amExpanded;
@property (nonatomic, assign, readwrite) BOOL amTransitioning;
@end

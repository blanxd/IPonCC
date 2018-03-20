#import "IPonCC.h"
#import "IPonCCview.h"

@implementation IPonCC
- (UIViewController<CCUIContentModuleContentViewController> *)contentViewController {
    return [[IPonCCview alloc] init];
}
@end

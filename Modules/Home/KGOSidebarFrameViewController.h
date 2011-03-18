/* because we have home screens like this,
 * ipad view controllers that wish to implement rotation methods
 * should use the app delegate's homescreen method and get its orientation
 * instead of using self.interfaceOrientation 
 */
#import "KGOHomeScreenViewController.h"

@class KGOModule;

@interface KGOSidebarFrameViewController : KGOHomeScreenViewController {
    
    UIView *_sidebar;
    UIView *_topbar;
    UIView *_container;
    
    UIViewController *_visibleViewController;
    NSArray *_widgetViews;
    
}

@property (nonatomic, readonly) UIViewController *visibleViewController;

- (void)showViewController:(UIViewController *)viewController;

@end

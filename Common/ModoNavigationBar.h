// UINavigationBar wrapper class.

#import <UIKit/UIKit.h>


@interface ModoNavigationBar : UINavigationBar /*<UINavigationBarDelegate>*/ {
    
    UINavigationBar *_navigationBar;

}

- (id)initWithNavigationBar:(UINavigationBar *)navigationBar;
- (void)update;

@property (nonatomic, assign) UINavigationBar *navigationBar;

@end

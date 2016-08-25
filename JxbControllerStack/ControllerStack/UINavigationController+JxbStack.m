//
//  UINavigationController+JxbStack.m
//  TripBaseUI
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "UINavigationController+JxbStack.h"
#import "UIViewController+JxbStack.h"
#import "JxbSwizzManager.h"
#import "JxbControllerStack.h"

@implementation UINavigationController (JxbStack)

+ (void)enable {
    SEL sel = @selector(pushViewController:animated:);
    SEL sel_new = @selector(JxbStack_pushViewController:animated:);
    [JxbSwizzManager replaceImplementationOfSelector:sel withSelector:sel_new cls:[self class]];
}

- (void)JxbStack_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self JxbStack_pushViewController:viewController animated:animated];
    NSInteger index = 0;
    if (self.tabBarController || self.viewControllers.count > 1) {
        [self addController:viewController];
    }
    else if (self.viewControllers.count == 1) {
        __weak typeof (self) wSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [wSelf addController:viewController];
        });
    }
}

- (void)addController:(UIViewController*)viewController {
    NSInteger index = 0;
    if (self.tabBarController) {
        //每个Nav的root不添加
        NSArray* arrVC = self.tabBarController.customizableViewControllers;
        index = [arrVC indexOfObject:self] + 1;
    }
    viewController.uniqueId = [NSString stringWithFormat:@"<%@>_%.0f",NSStringFromClass([viewController class]),[[NSDate date] timeIntervalSince1970]];
    viewController.tabIndex = @(index);
    [[JxbControllerStack sharedInstance] addController:viewController.uniqueId onTabIndex:index];
}

@end

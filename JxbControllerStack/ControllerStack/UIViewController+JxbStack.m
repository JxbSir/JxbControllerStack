//
//  UIViewController+JxbStack.m
//  TripBaseUI
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "UIViewController+JxbStack.h"
#import "JxbSwizzManager.h"
#import "JxbControllerStack.h"
#import <objc/runtime.h>

@implementation UIViewController (JxbStack)

+ (void)enable {
    SEL sel2 = @selector(viewDidAppear:);
    SEL sel2_new = @selector(JxbStack_viewDidAppear:);
    [JxbSwizzManager replaceImplementationOfSelector:sel2 withSelector:sel2_new cls:[self class]];
}

//- (void)dealloc {
//    NSString* uID = self.uniqueId;
//    NSNumber* index = self.tabIndex;
//    if (!uID) {
//        return;
//    }
//    [[JxbControllerStack sharedInstance] removeController:@"" onTabIndex:1];
//}

- (void)JxbStack_viewDidAppear:(BOOL)animated {
    [self JxbStack_viewDidAppear:animated];
    NSInteger index = 0;
    if (self.tabBarController) {
        //每个Nav的root不添加
        NSArray* arrVC = self.tabBarController.customizableViewControllers;
        index = [arrVC indexOfObject:self.navigationController] + 1;
    }
    [[JxbControllerStack sharedInstance] checkController:self.navigationController index:index];
}

- (NSString*)uniqueId {
    return objc_getAssociatedObject(self, @"uniqueId");
}

- (void)setUniqueId:(NSString*)uuid {
    objc_setAssociatedObject(self, @"uniqueId", uuid, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber*)tabIndex {
    return objc_getAssociatedObject(self, @"tabIndex");
}

- (void)setTabIndex:(NSNumber*)index {
    objc_setAssociatedObject(self, @"tabIndex", index, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

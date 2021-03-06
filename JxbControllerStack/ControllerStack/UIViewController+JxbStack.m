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

- (void)JxbStack_viewDidAppear:(BOOL)animated {
    [self JxbStack_viewDidAppear:animated];
    [[JxbControllerStack sharedInstance] checkController:self.navigationController index:self.tabIndex];
}

- (NSString*)uniqueId {
    return objc_getAssociatedObject(self, @"uniqueId");
}

- (void)setUniqueId:(NSString*)uuid {
    objc_setAssociatedObject(self, @"uniqueId", uuid, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)tabIndex {
    return objc_getAssociatedObject(self, @"tabIndex");
}

- (void)setTabIndex:(NSString*)index {
    objc_setAssociatedObject(self, @"tabIndex", index, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

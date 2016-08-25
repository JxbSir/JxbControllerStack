//
//  JxbSwizzManager.m_
//  TripBaseUI
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbSwizzManager.h"
#import <objc/runtime.h>

@interface JxbSwizzManager()

@end

@implementation JxbSwizzManager

+ (void)replaceImplementationOfSelector:(SEL)selector withSelector:(SEL)swizzledSelector cls:(Class)cls
{
    IMP implementation = class_getMethodImplementation(cls, swizzledSelector);
    Method oldMethod = class_getInstanceMethod(cls, selector);
    if (oldMethod) {
        const char* type = method_getTypeEncoding(oldMethod);
        class_addMethod(cls, swizzledSelector, implementation, type);
        Method newMethod = class_getInstanceMethod(cls, swizzledSelector);
        method_exchangeImplementations(oldMethod, newMethod);
    } else {
        class_addMethod(cls, selector, implementation, nil);
    }
}

@end

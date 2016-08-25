//
//  JxbSwizzManager.h
//  TripBaseUI
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JxbSwizzManager : NSObject

+ (void)replaceImplementationOfSelector:(SEL)selector withSelector:(SEL)swizzledSelector cls:(Class)cls;
@end

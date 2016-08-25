//
//  JxbControllerStack.h
//  TripBaseUI
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JxbControllerStack : NSObject

/**
 *  单例模式
 *
 *  @return 实例
 */
+ (instancetype)sharedInstance;

/**
 *  开启
 */
- (void)enable;

/**
 *  当Push时，添加一个到堆栈中
 *
 *  @param UniqueId 控制器唯一ID
 *  @param index    Tab的索引
 */
- (void)addController:(NSString*)UniqueId onTabIndex:(NSInteger)index;

/**
 *  当Dealloc时，从堆栈中移除
 *
 *  @param UniqueId 控制器唯一ID
 *  @param index    Tab的索引
 */
- (void)removeController:(NSString*)UniqueId onTabIndex:(NSInteger)index;

/**
 *  检测释放堆栈
 *
 *  @param nav 当前导航控制器
 */
- (void)checkController:(UINavigationController*)nav index:(NSInteger)index;


@end

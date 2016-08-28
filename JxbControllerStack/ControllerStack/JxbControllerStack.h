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
 *
 *  @param canHideByTap 弹出的提示是否可以通过点击关闭，默认NO
 */
- (void)enable;

/**
 *  开启
 *
 *  @param canHideByTap 弹出的提示是否可以通过点击关闭
 */
- (void)enable:(BOOL)canHideByTap;

/**
 *  设置监控TabVC的类名
 *
 *  @param classNames   类名数组
 */
- (void)setOnlyMonitorTabController:(NSArray*)classNames;

/**
 *  当Push时，添加一个到堆栈中
 *
 *  @param UniqueId 控制器唯一ID
 *  @param index    Tab的索引
 */
- (void)addController:(NSString*)UniqueId onTabIndex:(NSString*)index;

/**
 *  当Dealloc时，从堆栈中移除
 *
 *  @param UniqueId 控制器唯一ID
 *  @param index    Tab的索引
 */
- (void)removeController:(NSString*)UniqueId onTabIndex:(NSString*)index;

/**
 *  检测释放堆栈
 *
 *  @param nav 当前导航控制器
 */
- (void)checkController:(UINavigationController*)nav index:(NSString*)index;


@end

//
//  UIViewController+JxbStack.h
//  TripBaseUI
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JxbStack)

- (NSString*)uniqueId;
- (void)setUniqueId:(NSString*)uuid;

- (NSString*)tabIndex;
- (void)setTabIndex:(NSString*)index;

+ (void)enable;
@end

//
//  JxbControllerStack.m_
//  TripBaseUI
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbControllerStack.h"
#import "JxbSAsync.h"
#import "UIViewController+JxbStack.h"
#import "UINavigationController+JxbStack.h"

@interface JxbControllerStack()
@property (nonatomic, strong) NSMutableDictionary   *dicOfStack;

@property (nonatomic, strong) JxbSAsync          *safeAync;
@property (nonatomic, strong) UIView                *errorView;
@end

@implementation JxbControllerStack

+ (instancetype)sharedInstance {
    static JxbControllerStack *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JxbControllerStack alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)enable {
    [UIViewController enable];
    [UINavigationController enable];
}

#pragma mark - publick
- (void)addController:(NSString*)UniqueId onTabIndex:(NSString*)index {
    __weak typeof (self) wSelf = self;
    __block NSMutableArray* arrOfStack = nil;
    [self.safeAync addGetBlock:^{
        arrOfStack = (NSMutableArray*)wSelf.dicOfStack[index];
    }];
    [self.safeAync addWriteBlock:^{
        if (arrOfStack.count > 0) {
            [arrOfStack addObject:UniqueId];
        }
        else {
            [wSelf.dicOfStack setObject:[NSMutableArray arrayWithObject:UniqueId] forKey:index];
        }
    }];
}

- (void)removeController:(NSString*)UniqueId onTabIndex:(NSString*)index {
    __weak typeof (self) wSelf = self;
    __block NSMutableArray* arrOfStack = nil;
    [self.safeAync addGetBlock:^{
        arrOfStack = (NSMutableArray*)wSelf.dicOfStack[index];
    }];
    if (arrOfStack.count > 0) {
        [self.safeAync addWriteBlock:^{
            [arrOfStack removeObject:UniqueId];
        }];
    }
}

- (void)checkController:(UINavigationController*)nav index:(NSString*)index {
    if (index <= 0)
        return;
    __weak typeof(nav) wNav = nav;
    __weak typeof (self) wSelf = self;
    NSInteger count = wNav.viewControllers.count;
    NSLog(@"%zd",count);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger count_new = wNav.viewControllers.count;
        NSLog(@"%zd",count_new);
        if (count != count_new) {
            //导航器的内容已产生变化，本次检测取消
            return ;
        }
        __block NSArray* arrOfStack = nil;
        [wSelf.safeAync addGetBlock:^{
            arrOfStack = [(NSMutableArray*)wSelf.dicOfStack[index] copy];
        }];
        NSLog(@"arrOfStack:%@",arrOfStack);
        for (NSString* uuid in arrOfStack) {
            NSPredicate* p = [NSPredicate predicateWithFormat:@"SELF.uniqueId == %@",uuid];
            NSArray* results = [wNav.viewControllers filteredArrayUsingPredicate:p];
            if (results.count == 0) {
                NSString* msg = [NSString stringWithFormat:@"控制器\n[%@]\n没有被释放\n\n\n赶紧联系iOS开发人员，谢谢",uuid];
                wSelf.errorView.frame = wNav.view.bounds;
                UILabel* lbl = [[UILabel alloc] initWithFrame:wNav.view.bounds];
                lbl.text = msg;
                lbl.textAlignment = NSTextAlignmentCenter;
                lbl.textColor = [UIColor whiteColor];
                lbl.numberOfLines = 0;
                lbl.lineBreakMode = NSLineBreakByWordWrapping;
                [wSelf.errorView addSubview:lbl];
                if (wNav.tabBarController) {
                    [wNav.tabBarController.view addSubview:wSelf.errorView];
                }
                else {
                    [wNav.view addSubview:wSelf.errorView];
                }
                break;
            }
        }
    });
}

#pragma mark - kvo

#pragma mark - getter / setter
- (UIView*)errorView {
    if (!_errorView) {
        _errorView = [[UIView alloc] init];
        _errorView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    }
    return _errorView;
}

- (NSMutableDictionary*)dicOfStack {
    if (!_dicOfStack) {
        _dicOfStack = [NSMutableDictionary dictionary];
    }
    return _dicOfStack;
}

- (JxbSAsync*)safeAync {
    if (!_safeAync) {
        _safeAync = [[JxbSAsync alloc] init];
    }
    return _safeAync;
}
@end

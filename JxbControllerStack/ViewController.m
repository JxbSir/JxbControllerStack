//
//  ViewController.m
//  JxbControllerStack
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "ViewController.h"
#import "JxbControllStackApi.h"

@interface ViewController ()

@property (nonatomic, copy  ) void(^testBlock)(void);

@end

@implementation ViewController

-(void)dealloc {
#if DEBUG
    [[JxbControllerStack sharedInstance] removeController:self.uniqueId onTabIndex:self.tabIndex];
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testBlock = ^{
        //这里故意写了循环引用，会导致不会释放vc
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction {
    ViewController* vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end

//
//  JxbSafeAsync.m_
//  TripBaseUI
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbSAsync.h"

@interface JxbSAsync()
@property (nonatomic, strong) dispatch_queue_t  queue;
@end

@implementation JxbSAsync

- (void)addWriteBlock:(void(^)(void))block {
    dispatch_barrier_async(self.queue, block);
}

- (void)addGetBlock:(void(^)(void))block {
    dispatch_sync(self.queue, block);
}

#pragma mark - getter / setter
- (dispatch_queue_t)queue {
    if (!_queue) {
        _queue = dispatch_queue_create("name.Jxb.SAync", nil);
    }
    return _queue;
}
@end

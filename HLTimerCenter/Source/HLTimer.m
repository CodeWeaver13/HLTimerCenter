//
//  HLTimer.m
//  HLTimerCenter
//
//  Created by wangshiyu13 on 2016/9/25.
//  Copyright © 2016年 wangshiyu13. All rights reserved.
//

#import "HLTimer.h"

NSNotificationName const HLTimerCancelNotification = @"HLTimerCancelNotification";

@interface HLTimer ()
@property (nonatomic, assign)dispatch_time_t startTime;
@property (nonatomic)dispatch_source_t timer;
@property (nonatomic, assign)int tCount;
@property (nonatomic, assign)BOOL isRunning;
@end

@implementation HLTimer
- (instancetype)initWithTime:(NSTimeInterval)ti andAfterTime:(NSTimeInterval)afterTi andRepeatsCount:(int)repeatsCount isRepeats:(BOOL)isRepeats completionHandler:(void (^)())complete {
    self = [super init];
    if (self) {
        self.startTime = dispatch_time(DISPATCH_TIME_NOW, (NSEC_PER_SEC * afterTi));
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        self.isRunning = NO;
        dispatch_source_set_timer(self.timer, self.startTime, NSEC_PER_SEC * ti, 0);
        dispatch_source_set_event_handler(self.timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                complete();
            });
            self.tCount += 1;
            if (self.tCount == (isRepeats ? INTMAX_MAX : repeatsCount)) {
                [self cancel];
            }
        });
    }
    return self;
}

/**
 暂停Timer
 */
- (void)suspend {
    dispatch_suspend(self.timer);
    self.isRunning = NO;
}

/**
 取消Timer
 */
- (void)cancel {
    dispatch_source_cancel(self.timer);
    [[NSNotificationCenter defaultCenter] postNotificationName:HLTimerCancelNotification object:self];
}

/**
 启动Timer
 */
- (void)resume {
    dispatch_resume(self.timer);
    self.isRunning = YES;
}

#pragma mark - NSObject
- (NSUInteger)hash {
    return self.timer.hash;
}

- (BOOL)isEqualToTimer:(HLTimer *)timer {
    return [self hash] == [timer hash];
}

- (BOOL)isEqual:(id)object {
    if (self == object) return YES;
    if (![object isKindOfClass:[HLTimer class]]) return NO;
    return [self isEqualToTimer:(HLTimer *)object];
}
@end

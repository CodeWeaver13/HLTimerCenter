//
//  HLTimerCenter.m
//  HLTimerCenter
//
//  Created by wangshiyu13 on 2016/9/25.
//  Copyright © 2016年 wangshiyu13. All rights reserved.
//

#import "HLTimerCenter.h"
#import "HLTimer.h"

static HLTimerCenter *_defaultCenter = nil;

@interface HLTimerCenter ()
@property(nonatomic, copy)NSMutableSet<HLTimer *> *queue;
@end

@implementation HLTimerCenter
+ (nullable HLTimerCenter *)defaultCenter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultCenter = [[self alloc] init];
    });
    return _defaultCenter;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(awakeAllTimer) name:NSExtensionHostDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sleepAllTimer) name:NSExtensionHostDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimerInNote:) name:HLTimerCancelNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (HLTimer *)createTimer:(NSTimeInterval)ti afterTime:(NSTimeInterval)afterTime repeatsCount:(int)repeatsCount repeats:(BOOL)repeats autoPlay:(BOOL)autoPlay handler:(void (^ )())handler {
    HLTimer *timer = [[HLTimer alloc] initWithTime:ti andAfterTime:afterTime andRepeatsCount:repeatsCount isRepeats:repeats completionHandler:handler];
    [self addTimer:timer autoPlay:autoPlay];
    return timer;
}

/**
 添加Timer
 
 - parameter timer:    Timer对象
 - parameter autoPlay: 是否自动执行
 */
- (void)addTimer:(HLTimer *)timer autoPlay:(BOOL)autoPlay {
    if (![self.queue containsObject:timer]) {
        [self.queue addObject:timer];
        if (autoPlay) [timer resume];
    }
}

/**
 移除Timer
 
 - parameter timer: 需要移除的Timer对象
 */
- (void)removeTimer:(HLTimer *)timer {
    [timer cancel];
    if ([self.queue containsObject:timer]) {
        [self.queue removeObject:timer];
    }
}

- (void)removeTimerInNote:(HLTimer *)timer {
    if ([self.queue containsObject:timer]) {
        [self.queue removeObject:timer];
    }
}

#pragma mark - event func
- (void)sleepAllTimer {
    [self.queue enumerateObjectsUsingBlock:^(HLTimer * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isRunning]) {
            [obj suspend];
        }
    }];
}

- (void)awakeAllTimer {
    [self.queue enumerateObjectsUsingBlock:^(HLTimer * _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj isRunning]) {
            [obj resume];
        }
    }];
}

#pragma mark - getter / lazy load
- (NSSet<HLTimer *> *)queue {
    if (!_queue) {
        _queue = [NSMutableSet set];
    }
    return _queue;
}
@end

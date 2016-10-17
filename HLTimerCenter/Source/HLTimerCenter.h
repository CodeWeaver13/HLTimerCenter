//
//  HLTimerCenter.h
//  HLTimerCenter
//
//  Created by wangshiyu13 on 2016/9/25.
//  Copyright © 2016年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLTimer.h"

@interface HLTimerCenter : NSObject

/**
 单例

 @return HLTimerCenter
 */
+ (nullable HLTimerCenter *)defaultCenter;

/**
 创建Timer并添加进TimerCenter
 
 - parameter ti:           间隔时间
 - parameter afterTime:    延迟时间按
 - parameter repeatsCount: 循环次数
 - parameter repeats:      是否一直循环
 - parameter autoPlay:     是否自动执行
 - parameter handler:      Timer回调，回调默认在主线程
 
 - returns: 返回Timer对象
 */
- (HLTimer * _Nullable)createTimer:(NSTimeInterval)ti afterTime:(NSTimeInterval)afterTime repeatsCount:(int)repeatsCount repeats:(BOOL)repeats autoPlay:(BOOL)autoPlay handler:(void ( ^ _Nullable )())handler;

- (void)addTimer:(HLTimer * _Nullable)timer autoPlay:(BOOL)autoPlay;

- (void)removeTimer:(HLTimer * _Nullable)timer;
@end

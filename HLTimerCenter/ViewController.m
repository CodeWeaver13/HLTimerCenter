//
//  ViewController.m
//  HLTimerCenter
//
//  Created by wangshiyu13 on 2016/9/25.
//  Copyright © 2016年 wangshiyu13. All rights reserved.
//

#import "ViewController.h"
#import "HLTimerCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HLTimerCenter defaultCenter] createTimer:1
                                     afterTime:0
                                  repeatsCount:5
                                       repeats:NO
                                      autoPlay:YES
                                       handler:^{
                                           dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                               NSLog(@"我真屌");
                                           });
                                       }];
    
    
    [[[HLTimerCenter defaultCenter] createTimer:1 afterTime:5 repeatsCount:1 repeats:false autoPlay:NO handler:^{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
    }] resume];
    
    NSLog(@"要睡了");
    [NSThread sleepForTimeInterval:10];
    NSLog(@"睡饱了");
}
@end

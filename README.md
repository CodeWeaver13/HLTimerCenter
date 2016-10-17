# HLTimerCenter
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/wangshiyu13/HLQRCodeScanner/blob/master/LICENSE)
[![CI Status](https://img.shields.io/badge/build-1.0.0-brightgreen.svg)](https://travis-ci.org/wangshiyu13/HLQRCodeScanner)
[![CocoaPods](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](http://cocoapods.org/?q= HLQRCodeScanner)
[![Support](https://img.shields.io/badge/support-iOS%208%2B-blue.svg)](https://www.apple.com/nl/ios/)
#### 基于GCD的定时管理器
##特点
1. 基于GCD实现的定时器，稳定好用
2. 提供Center进行定时器统一管理
3. 当APP进入后台时自动暂停所有定时器，APP恢复时统一唤醒

====

##使用方法

### 一、HLAPI相关

1) 直接创建

```objective-c
[[HLTimerCenter defaultCenter] createTimer:1 afterTime:0 repeatsCount:5 repeats:NO autoPlay:YES handler:^{
	NSLog(@"泡一下");
}];
```

2) 分步创建

```objective-c
HLTimer *timer = [[HLTimer alloc] initWithTime:1 andAfterTime:0 andRepeatsCount:5 isRepeats:NO completionHandler:^{
        NSLog(@"跑一下");
    }];
    
[[HLTimerCenter defaultCenter] addTimer:timer autoPlay:NO];
```

## 环境要求

该库需运行在 iOS 8.0 和 Xcode 7.0以上环境.

## 集成方法

HLTimerCenter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HLTimerCenter"
```

## 作者

wangshiyu13, wangshiyu13@163.com

## 开源协议

HLNetworking is available under the MIT license. See the LICENSE file for more info.

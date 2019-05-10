//
//  Target_RuntimeDemo.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RuntimeDemoViewController;
NS_ASSUME_NONNULL_BEGIN

@interface Target_RuntimeDemo : NSObject
- (RuntimeDemoViewController *)Action_nativeFetchDetailViewController;
- (id)Action_presentImage:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END

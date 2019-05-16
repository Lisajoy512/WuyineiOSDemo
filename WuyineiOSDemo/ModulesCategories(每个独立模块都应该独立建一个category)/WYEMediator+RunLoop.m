//
//  WYEMediator+RunLoop.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/14.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEMediator+RunLoop.h"

@implementation WYEMediator (RunLoop)
- (UIViewController *)WYEMediator_detailRunLoopDemoDetailVC {
    UIViewController *detail = [self performTarget:@"RunLoop" action:@"nativeFetchDetailController" params:@{}];
    if (detail) {
        return detail;
    }else {
        return [UIViewController new];
    }
}
@end

//
//  WYEMediator+MutiThreadModuleActions.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/28.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEMediator+MutiThreadModuleActions.h"

@implementation WYEMediator (MutiThreadModuleActions)

- (UIViewController *)WYEMediator_viewControllerForDetail {
    UIViewController *controller = [self performTarget:@"MutiThread" action:@"nativeFetchDetailViewController" params:@{}];
    if ([controller isKindOfClass:[UIViewController class]]) {
        return controller;
    }else {
        return [UIViewController new];
    }
}
@end

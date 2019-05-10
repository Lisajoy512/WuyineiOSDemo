//
//  WYEMediator+LogRedirect.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/29.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEMediator+LogRedirect.h"

@implementation WYEMediator (LogRedirect)
- (UIViewController *)WYEMediator_logViewControllerForDetail {
    UIViewController *controller = [self performTarget:@"Log" action:@"nativeFetchDetailViewController" params:@{}];
    if ([controller isKindOfClass:[UIViewController class]]) {
        return controller;
    }else {
        return [UIViewController new];
    }
}
@end

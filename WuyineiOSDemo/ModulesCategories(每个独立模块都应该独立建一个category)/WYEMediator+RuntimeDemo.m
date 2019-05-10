//
//  WYEMediator+RuntimeDemo.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEMediator+RuntimeDemo.h"

@implementation WYEMediator (RuntimeDemo)
- (UIViewController *)WYEMediator_runtimeDemoDetailViewController {
    UIViewController *runtimeDemo = [self performTarget:@"RuntimeDemo" action:@"nativeFetchDetailViewController" params:@{}];
    if (runtimeDemo) {
        return runtimeDemo;
    }else {
        return [UIViewController new];
    }
}

- (id)WYEMediator_presenrImageViewController:(NSDictionary *)params {
    return [self performTarget:@"RuntimeDemo" action:@"presentImage:" params:params];
}
@end

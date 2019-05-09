//
//  WYEMediator+MultiTableView.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/9.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEMediator+MultiTableView.h"

@implementation WYEMediator (MultiTableView)
- (UIViewController *)WYEMediator_multiTableViewDetailController {
    UIViewController *vc = [self performTarget:@"MultiTableView" action:@"nativeFetchDetailViewController" params:@{}];
    if (vc) {
        return vc;
    }else {
        return [UIViewController new];
    }
}
@end

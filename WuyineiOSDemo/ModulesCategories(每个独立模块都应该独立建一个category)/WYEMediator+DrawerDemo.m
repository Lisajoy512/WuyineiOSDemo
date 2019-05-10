//
//  WYEMediator+DrawerDemo.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/8.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEMediator+DrawerDemo.h"

@implementation WYEMediator (DrawerDemo)
- (UIViewController *)WYEMediator_drawerDemoDetailViewController {
    UIViewController *controller = [self performTarget:@"Drawer" action:@"nativeFetchDetailViewController" params:@{}];
    if (controller) {
        return controller;
    }else {
        return [UIViewController new];
    }
}
@end

//
//  Target_Drawer.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/8.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "Target_Drawer.h"
#import "DrawerViewController.h"
#import "MenuViewController.h"
#import "CenterViewController.h"
@implementation Target_Drawer
- (DrawerViewController *)Action_nativeFetchDetailViewController {
    MenuViewController *menu = [[MenuViewController alloc] init];
    CenterViewController *center = [[CenterViewController alloc] init];
    DrawerViewController *drawer = [DrawerViewController mainViewControllerWithMenuViewController:menu witCenterViewController:center];
    
    return drawer;
}
@end

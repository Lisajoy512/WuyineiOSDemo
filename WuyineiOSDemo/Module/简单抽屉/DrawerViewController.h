//
//  DrawerViewController.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/8.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawerViewController : ViewController
+ (instancetype)mainViewControllerWithMenuViewController:(UIViewController *)menuViewController witCenterViewController:(UIViewController *)centerViewController;
@end

NS_ASSUME_NONNULL_END

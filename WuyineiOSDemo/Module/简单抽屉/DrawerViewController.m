//
//  DrawerViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/8.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "DrawerViewController.h"
#import "MenuViewController.h"
#import "CenterViewController.h"
#import "Masonry.h"
@interface DrawerViewController ()
@property (nonatomic,strong) MenuViewController *menuVC;
@property (nonatomic,strong) CenterViewController *centerVC;
@end

@implementation DrawerViewController

+ (instancetype)mainViewControllerWithMenuViewController:(UIViewController *)menuViewController witCenterViewController:(UIViewController *)centerViewController{

    DrawerViewController *mainVC = [[DrawerViewController alloc] init];
    mainVC.menuVC = menuViewController;
    mainVC.centerVC = centerViewController;
    return mainVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:self.menuVC];
    [self.view addSubview:self.menuVC.view];
    [self.menuVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(150);
    }];
    
    [self addChildViewController:self.centerVC];
    [self.view addSubview:self.centerVC.view];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.backgroundColor = [UIColor redColor];
    [back setImage:[UIImage imageNamed:@"ic_top_back_white"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerVC.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 40));
        make.top.mas_equalTo(StatusBarHeight + 10);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"设置" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openDrawer:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerVC.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(60, 40));
        make.top.mas_equalTo(StatusBarHeight + 10);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)back:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)openDrawer:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.isSelected) {
        [UIView beginAnimations:nil context:nil];
        self.centerVC.view.center =  CGPointMake([UIScreen mainScreen].bounds.size.width * 1 /2 - 150, [UIScreen mainScreen].bounds.size.height / 2);
        [UIView commitAnimations];
    }else {
        [UIView beginAnimations:nil context:nil];
        self.centerVC.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        [UIView commitAnimations];
    }
}

@end

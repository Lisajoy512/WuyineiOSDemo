//
//  RootViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/9.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "RootViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import <Masonry.h>
@interface RootViewController ()
@property (nonatomic,strong) LeftViewController *leftVC;
@property (nonatomic,strong) RightViewController *rightVC;
@property (nonatomic,strong) NSArray *totalData;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.leftVC];

    [self.view addSubview:self.leftVC.view];
    [self.leftVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH*0.25);
    }];
    
    [self addChildViewController:self.rightVC];

    [self.view addSubview:self.rightVC.view];
    [self.rightVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.bottom.mas_equalTo(0);
        make.leading.equalTo(self.leftVC.view.mas_trailing);
    }];
    
    self.totalData = @[
                       @[@"content 1",
                         @"content 1",
                         @"content 1"],
                       @[@"content 2",
                         @"content 2",
                         @"content 2"],
                       @[@"content 3",
                         @"content 3",
                         @"content 3"],
                       @[@"content 4",
                         @"content 4",
                         @"content 4"],
                       @[@"content 5",
                         @"content 5",
                         @"content 5"],
                       @[@"content 6",
                         @"content 6",
                         @"content 6"],
                       @[@"content 7",
                         @"content 7",
                         @"content 7"],
                       ];
    self.leftVC.tableViewBackColor = [UIColor redColor];
    self.rightVC.tableViewBackColor = [UIColor greenColor];
    self.rightVC.dataArray = [self.totalData firstObject];

}

- (LeftViewController *)leftVC {
    if (!_leftVC) {
        _leftVC = [[LeftViewController alloc] init];
//        __weak RootViewController *weakSelf = self;
        __weak typeof(self) weakSelf = self;
        [_leftVC setClickBlock:^(NSInteger selectIndex) {
            weakSelf.rightVC.dataArray = [weakSelf.totalData objectAtIndex:selectIndex];
        }];
    }
    return _leftVC;
}

- (RightViewController *)rightVC {
    if (!_rightVC) {
        _rightVC = [[RightViewController alloc] init];
    }
    return _rightVC;
}

@end

//
//  LeftViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/9.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"menu 1",
                       @"menu 2",
                       @"menu 3",
                       @"menu 4",
                       @"menu 5",
                       @"menu 6",
                       @"menu 7"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickBlock) {
        self.clickBlock(indexPath.row);
    }
}

@end

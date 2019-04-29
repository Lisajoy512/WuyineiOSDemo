//
//  ViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/28.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "ViewController.h"
#import "WYEMediator+MutiThreadModuleActions.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WuyineDemo";
    self.dataArray = @[@"NSOperation and NSOperationQueue"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            case 0: {
                UIViewController *detail = [[WYEMediator shareInstance] WYEMediator_viewControllerForDetail];
                [self.navigationController pushViewController:detail animated:YES];
            }
            break;
            
        default:
            break;
    }
}
@end

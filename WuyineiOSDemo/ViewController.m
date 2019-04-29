//
//  ViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/28.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "ViewController.h"
#import "WYEMediator+MutiThreadModuleActions.h"
#import "WYEMediator+LogRedirect.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WuyineDemo";
    self.dataArray = @[@"多线程NSOperation and NSOperationQueue",
                       @"日志重定向 fishhook and stderr"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            case 0: {
                UIViewController *detail = [[WYEMediator shareInstance] WYEMediator_viewControllerForDetail];
                [self.navigationController pushViewController:detail animated:YES];
            }
            break;
            case 1: {
                UIViewController *detail = [[WYEMediator shareInstance] WYEMediator_logViewControllerForDetail];
                [self.navigationController pushViewController:detail animated:YES];
            }
            break;
            
        default:
            break;
    }
}
@end

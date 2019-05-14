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
#import "WYEMediator+DrawerDemo.h"
#import "WYEMediator+MultiTableView.h"
#import "WYEMediator+RuntimeDemo.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WuyineDemo";
    self.dataArray = @[@"0 多线程NSOperation and NSOperationQueue",
                       @"1 日志重定向 fishhook and stderr",
                       @"2 简单抽屉Demo",
                       @"3 一个ViewController中多个tableView（childViewController）",
                       @"4 runtime 消息重载、消息接收者转发、消息转发等demo",
                       @"5 runtime 应用图",
                       @"6 runloop Demo"
                       ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
            case 2: {
                UIViewController *detail = [[WYEMediator shareInstance] WYEMediator_drawerDemoDetailViewController];
                [self.navigationController pushViewController:detail animated:YES];
            }
                break;
            case 3: {
                UIViewController *detail = [[WYEMediator shareInstance] WYEMediator_multiTableViewDetailController];
                [self.navigationController pushViewController:detail animated:YES];
            }
                break;
            case 4: {
                UIViewController *detail = [[WYEMediator shareInstance] WYEMediator_runtimeDemoDetailViewController];
                [self.navigationController pushViewController:detail animated:YES];
            }
                break;
            case 5: {
                [[WYEMediator shareInstance] WYEMediator_presenrImageViewController:@{@"imageName":@"runtime实用篇"}];
            }
                break;
        default:
            break;
    }
}
@end

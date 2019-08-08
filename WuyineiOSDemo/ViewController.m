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
#import "WYEMediator+RunLoop.h"
#import "WYEMediator+KVCandKVO.h"
#import "WYEMediator+NSURLSession.h"

#import "WuyineiOSDemo-Swift.h"
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
                       @"6 runloop Demo",
                       @"7 GCD Demo（后续整理）",
                       @"8 NSTimer循环引用demo",
                       @"9 KVC and KVO demo",
                       @"10 block相关",
                       @"11 NSURLSession相关",
                       @"12 动画测试"
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
            case 6: {
                UIViewController *detail = [[WYEMediator shareInstance] WYEMediator_detailRunLoopDemoDetailVC];
                [self.navigationController pushViewController:detail animated:YES];
            }
                break;
            case 9: {
                UIViewController *detail = [[WYEMediator shareInstance] WYEMediator_detailKVCandKVOController];
                [self.navigationController pushViewController:detail animated:YES];
            }
                break;
            case 10: {
                //下面两段代码唯一区别就是一个用__block修饰符修饰，一个没有。不用修饰符修饰是传值，用了修饰符是传址。
                int i = 10;
                void (^block)(void) = ^() {
                    int j = i;
                    NSLog(@"a,num = %i,%i",j,i);  //a,num = 10,10
                };
                i = 20;
                block();
                
                __block int n = 10;
                void (^blockNew)(void) = ^() {
                    int m = n;
                    NSLog(@"a,num = %i,%i",m,n);  //a,num = 20,20
                };
                n = 20;
                blockNew();
                
                __block int k = 10;
                void (^blockNew2)(void) = ^() {
                    k = k+10;
                    int l = k;
                    NSLog(@"l,num = %i,%i",l,k);  //l,num = 30,30
                };
                k = 20;
                blockNew2();
            }
                break;
            case 11: {
                UIViewController *vc = [[WYEMediator shareInstance] WYEMediator_detailNSURLSessionDetailVCController];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            case 12: {
                UIViewController *vc = [[WYEMediator shareInstance] WYEMediator_detailAnimationVC];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
        default:
            break;
    }
}
@end

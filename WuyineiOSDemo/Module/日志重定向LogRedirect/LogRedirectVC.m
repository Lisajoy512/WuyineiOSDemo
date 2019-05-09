//
//  LogRedirectVC.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/29.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "LogRedirectVC.h"
#import "fishhook.h"
#import <mach/task_info.h>
#import <mach/task.h>


@implementation LogRedirectVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"CocoaLumberjack",
                       @"fishhook(二和三只能二选一，一次只能运行一个，否则会出现乱套)",
                       @"dup2 函数和 STDERR 句柄(二和三只能二选一，一次只能运行一个，否则会出现乱套)"
                       ];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            case 0: {
                
            }
            break;
            case 1: {
                [self redirectSTD:STDOUT_FILENO];
                [self fishhookDemo];
                NSLog(@"fish hook");
            }
            break;
            case 2: {
                [self dup2AndSTDERRDemo];
                NSLog(@"使用句柄重定向");
            }
        default:
            break;
    }
}

#pragma mark -- hook
- (void)fishhookDemo {
    //定义rebinding 结构体
    struct rebinding rebind = {};
    rebind.name = "NSLog";
    rebind.replacement = hookNSLog;
    rebind.replaced = (void *)&nslogMethod;

    //将上面的结构体 放入 reb结构体数组中
    struct rebinding red[]  = {rebind};

    /*
     * arg1 : 结构体数据组
     * arg2 : 数组的长度
     */

    rebind_symbols(red, 1);
}

//定义一个函数指针 用于指向原来的NSLog函数
static void (*nslogMethod)(NSString *format, ...);

void hookNSLog(NSString *format, ...){
    format = [format stringByAppendingString:@"被勾住了"];
    nslogMethod(format);
}

#pragma mark -- dup2 and stderr
- (void)dup2AndSTDERRDemo {
    [self redirectSTD:STDERR_FILENO];
}

- (void)redirectSTD:(int )fd{
    NSPipe * pipe = [NSPipe pipe] ;
    NSFileHandle *pipeReadHandle = [pipe fileHandleForReading] ;
    int pipeFileHandle = [[pipe fileHandleForWriting] fileDescriptor];
    dup2(pipeFileHandle, fd) ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(redirectNotificationHandle:)
                                                 name:NSFileHandleReadCompletionNotification
                                               object:pipeReadHandle] ;
    [pipeReadHandle readInBackgroundAndNotify];
}

- (void)redirectNotificationHandle:(NSNotification *)nf{
    NSData *data = [[nf userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
    //这里可以做我们需要的操作,例如将nslog显示到一个textview中,或者是存放到另一个文件中等等，这里选择用alertView展示
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"截获nslog输出" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:ok];
     
    [self presentViewController:alert animated:YES completion:nil];
    
    [[nf object] readInBackgroundAndNotify];
}
@end

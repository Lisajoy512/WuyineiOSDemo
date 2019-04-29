//
//  MutiThreadViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/28.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "MutiThreadViewController.h"
#import "WYEOperation.h"
@interface MutiThreadViewController ()
@end

@implementation MutiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"NSInvokeOperation",
                       @"NSBlockOperation",
                       @"自定义的NSOperation",
                       @"NSOperationQueue addOperation",
                       @"NSOperationQueue  addOperationWithBlock",
                       @"NSOperationQueue maxConcurrentOperationCount",
                       @"NSOperationQueue  操作依赖"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            case 0: {
                [self invokeOperationDemo];
            }
            break;
            case 1: {
                [self blockOperationDemo];
            }
            break;
            case 2: {
                [self customOperationDemo];
            }
            case 3: {
                [self queueAddOperation];
            }
            break;
            case 4: {
                [self queueAddOperationBlock];
            }
            break;
            case 5: {
                [self maxConcurrentOpCountDemo];
            }
            break;
            case 6: {
                [self operationDependencyDemo];
            }
            break;
        default:
            break;
    }
}

#pragma mark -- NSInvokeOperation
- (void)invokeOperationDemo {
    //1.创建NSInvocationOperation对象
    NSInvocationOperation *invoke = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invokeOperationRun) object:nil];
    
    //2.调用start方法开始
    [invoke start];
}

- (void)invokeOperationRun {
    //（未开启新线程）
    NSLog(@"----invokeOperationRun------%@",[NSThread currentThread]);
}

#pragma mark -- NSBlockOperation
- (void)blockOperationDemo {
    //1.创建NSBlockOperation对象
    NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
        //未开启新线程，还在主线程
        NSLog(@"-----blockOperationRun------%@",[NSThread currentThread]);
    }];
    
    //2.新增任务，开启新线程
    [block addExecutionBlock:^{
        //开启新线程
        NSLog(@"-----blockOperationRun 1------%@",[NSThread currentThread]);
    }];
    
    //3.新增任务，开启新线程
    [block addExecutionBlock:^{
        //开启新线程
        NSLog(@"-----blockOperationRun 2------%@",[NSThread currentThread]);
    }];
    
    //4.新增任务，开启新线程
    [block addExecutionBlock:^{
        //开启新线程
        NSLog(@"-----blockOperationRun 3------%@",[NSThread currentThread]);
    }];
    
    //5.调用start方法开始
    [block start];
}

#pragma mark -- 自定义Operation
- (void)customOperationDemo {
    WYEOperation *wyeOp = [[WYEOperation alloc] init];
    [wyeOp start];
}

#pragma mark -- NSOperationQueue addOperation
- (void)queueAddOperation {
    //主队列，在主线程执行
    NSOperationQueue *main = [NSOperationQueue mainQueue];
    NSInvocationOperation *invocationOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invokeOperationRun) object:nil];
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---queue:blockOperation run----%@",[NSThread currentThread]);
    }];
    [main addOperation:invocationOp];  //invocationOp start
    [main addOperation:blockOp];  //block start
    
    //其他队列，会放到子线程去执行。其他队列每addOperation会开启一个新线程
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *invocationOp1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invokeOperationRun) object:nil];
    NSBlockOperation *blockOp1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---queue:blockOperation run1----%@",[NSThread currentThread]);
    }];
    [queue addOperation:invocationOp1];  //invocationOp1 start
    [queue addOperation:blockOp1];  //block1 start
}

#pragma mark -- NSOperationQueue addOperation
- (void)queueAddOperationBlock {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = -1;  //默认为-1，并发执行
    [queue addOperationWithBlock:^{
        NSLog(@"===1====%@",[NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"===2====%@",[NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"===3====%@",[NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"===4====%@",[NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"===5====%@",[NSThread currentThread]);
    }];
}

#pragma mark -- maxConcurrentOperationCount
- (void)maxConcurrentOpCountDemo {
    
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger i = 0; i < 6; i++) {
            NSLog(@"===%i===%@",i,[NSThread currentThread]);
        }
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;  //保证了顺序执行，但依然开启了新线程。因为maxConcurrentOperationCount控制的是一次只有一个operation在执行，而不是说只开启一个线程。开启线程数量是由系统控制的
    [queue addOperation:blockOp];
    
    [queue addOperationWithBlock:^{
        NSLog(@"===6====%@",[NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"===7====%@",[NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"===8====%@",[NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"===9====%@",[NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"===10====%@",[NSThread currentThread]);
    }];
}

#pragma mark -- opration dependency
- (void)operationDependencyDemo {
    //其他队列，会放到子线程去执行。其他队列每addOperation会开启一个新线程
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    NSInvocationOperation *invocationOp1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invokeOperationRun) object:nil];
    NSBlockOperation *blockOp1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---queue:blockOperation run1----%@",[NSThread currentThread]);
    }];
    [invocationOp1 addDependency:blockOp1];  //blockOp先执行
    
    [queue addOperation:invocationOp1];  //invocationOp1 start
    [queue addOperation:blockOp1];  //block1 start
    
}

@end

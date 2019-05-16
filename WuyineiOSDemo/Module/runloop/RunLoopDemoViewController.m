//
//  RunLoopDemoViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/14.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "RunLoopDemoViewController.h"

@interface RunLoopDemoViewController ()
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) UILabel *countDown;
@property (nonatomic,strong) UIImageView *delayImageView;
@end

@implementation RunLoopDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn1];
    btn1.frame = CGRectMake(20, 100, 150, 50);
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 setTitle:@"基于端口的输入源" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(portRunLoop:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn2];
    btn2.frame = CGRectMake(20, 200, 150, 50);
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 setTitle:@"timer测试" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(timerRunLoop:) forControlEvents:UIControlEventTouchUpInside];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(180, 200, 200, 300)];
    [scroll setContentSize:CGSizeMake(300, 450)];
    [self.view addSubview:scroll];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    [imageView setFrame:CGRectMake(0, 0, 1200, 1800)];
    [scroll addSubview:imageView];
    
    self.count = 100;
    self.countDown = [[UILabel alloc] init];
    self.countDown.text = [NSString stringWithFormat:@"%d",self.count];
    [self.countDown setFrame:CGRectMake(20, 280, 100, 100)];
    [self.view addSubview:self.countDown];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn3];
    btn3.frame = CGRectMake(20, 350, 150, 50);
    btn3.backgroundColor = [UIColor greenColor];
    [btn3 setTitle:@"延迟图片加载" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(delayImageShow) forControlEvents:UIControlEventTouchUpInside];
    
    self.delayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 450, 60, 60)];
    self.delayImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.delayImageView];
}

- (void)portRunLoop:(UIButton *)btn {
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(portRun1) object:nil];
    [thread1 start];
}

- (void)portRun1 {
    NSLog(@"----run1 start-----%@",[NSThread currentThread]);
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"----run1 end-----%@",[NSThread currentThread]);
}

- (void)timerRunLoop:(UIButton *)btn {
    
    //最原始的timer用法，注意的是无需fire会自启动，但是会wait TimeInterval：1之后再自启动
    //拖拽图片时timer倒计时无法实时展示
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        self.count --;
//        self.countDown.text = [NSString stringWithFormat:@"%d",self.count];
//    }];
    
    //第一种方法：将timer加入到NSRunLoopCommonModes
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.count --;
        self.countDown.text = [NSString stringWithFormat:@"%ld",(long)self.count];
        if (self.count == 0) {
            [timer invalidate];
            timer = nil;
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    
    //第二种方法：在子线程创建timer并将runloop run起来
//    NSThread *sub = [[NSThread alloc] initWithTarget:self selector:@selector(subThreadRun) object:nil];
//    [sub start];
}

- (void)subThreadRun {
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.count --;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.countDown.text = [NSString stringWithFormat:@"%d",self.count];
        });
    }];
    
    //必须让runloop 运行起来，否则timer仅执行一次
    [runloop run];
}

- (void)delayImageShow {
    
    //点击图片延迟展示button后，应该5s之后显示图片。但点击按钮之后，如果一直拖动页面上的scroolview，使得一直处于UITrackingRunLoopMode之下，此时图片也不会展示。
    //此处展示适用于滑动列表时，延迟列表里的图片展示，以免引起列表滑动卡顿
    [self.delayImageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"1"] afterDelay:5 inModes:@[NSDefaultRunLoopMode]];
    
    //NSObject 的 performSelecter:afterDelay: 后，实际上其内部会创建一个 Timer 并添加到当前线程的 RunLoop 中。所以如果当前线程没有 RunLoop，则这个方法会失效。
    //当调用 performSelector:onThread: 时，实际上其会创建一个 Timer 加到对应的线程去，同样的，如果对应线程没有 RunLoop 该方法也会失效。
}
@end

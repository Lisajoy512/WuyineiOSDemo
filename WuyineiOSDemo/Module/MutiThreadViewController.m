//
//  MutiThreadViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/28.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "MutiThreadViewController.h"

@interface MutiThreadViewController ()
@end

@implementation MutiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"NSInvokeOpearion",@"NSBlockOperation",@"自定义的NSOperation",@"NSOperationQueue addOperation",@"NSOperationQueue  addOperationWithBlock",@"NSOperationQueue maxConcurrentOperationCount",@"NSOperationQueue  操作依赖"];
    
}

@end

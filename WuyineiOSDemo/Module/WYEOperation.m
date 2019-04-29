//
//  WYEOperation.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/29.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEOperation.h"

@implementation WYEOperation

- (void)main {
    for (NSInteger i = 0; i < 3; i++) {
        //每次都未开启新线程
        NSLog(@"------WYEOperation %i-----,%@",i,[NSThread currentThread]);
    }
}


@end

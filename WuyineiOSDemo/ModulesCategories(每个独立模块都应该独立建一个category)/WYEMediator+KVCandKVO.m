//
//  WYEMediator+KVCandKVO.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/15.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEMediator+KVCandKVO.h"

@implementation WYEMediator (KVCandKVO)
- (UIViewController *)WYEMediator_detailKVCandKVOController {
    UIViewController *detail = [self performTarget:@"KVCandKVO" action:@"nativeFetchDetailController" params:@{}];
    if (detail) {
        return detail;
    }else {
        return [UIViewController new];
    }
}
@end

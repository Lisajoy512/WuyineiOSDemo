//
//  WYEMediator+NSURLSession.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/7/30.
//  Copyright © 2019 wuyine. All rights reserved.
//

#import "WYEMediator+NSURLSession.h"

@implementation WYEMediator (NSURLSession)
- (UIViewController *)WYEMediator_detailNSURLSessionDetailVCController {
    UIViewController *vc = [self performTarget:@"NSURLSession" action:@"nativeFetchNSURLSessionDetailViewCOntroller" params:@{}];
    if (vc) {
        return vc;
    }else {
        return [UIViewController new];
    }
}

@end

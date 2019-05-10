//
//  Target_RuntimeDemo.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "Target_RuntimeDemo.h"
#import "RuntimeDemoViewController.h"
#import "RunTimePraticalViewController.h"
@implementation Target_RuntimeDemo
- (RuntimeDemoViewController *)Action_nativeFetchDetailViewController {
    RuntimeDemoViewController *runtime = [[RuntimeDemoViewController alloc] init];
    return runtime;
}

- (id)Action_presentImage:(NSDictionary *)params {
    NSString *imageName = [params objectForKey:@"imageName"];
    RunTimePraticalViewController *imagePresent = [[RunTimePraticalViewController alloc] init];
    imagePresent.imageName = imageName;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePresent animated:YES completion:nil];
    return nil;
}
@end

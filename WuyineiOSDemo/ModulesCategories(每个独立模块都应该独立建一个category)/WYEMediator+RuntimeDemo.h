//
//  WYEMediator+RuntimeDemo.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYEMediator (RuntimeDemo)
- (UIViewController *)WYEMediator_runtimeDemoDetailViewController;
- (id)WYEMediator_presenrImageViewController:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END

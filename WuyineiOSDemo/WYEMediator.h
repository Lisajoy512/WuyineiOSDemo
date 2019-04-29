//
//  WYEMediator.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/28.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WYEMediator : NSObject
+ (instancetype)shareInstance;

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END

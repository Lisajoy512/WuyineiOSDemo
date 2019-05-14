//
//  NSObject+WYEModel.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/13.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//WYEModel协议，协议方法可以返回一个字典，表明特殊字段的处理规则
@protocol WYEModel<NSObject>
@optional
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass;
@end;

@interface NSObject (WYEModel)
+ (instancetype)wye_modelWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END


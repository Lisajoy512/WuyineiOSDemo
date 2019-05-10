//
//  Person.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
//声明类方法，但未实现
+ (void)haveMeal:(NSString *)food;
//声明实例方法，但未实现
- (void)singSong:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

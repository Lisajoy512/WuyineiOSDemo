//
//  Person.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+WYEModel.h"
#import "Student.h"
#import "Teacher.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<WYEModel>
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;

//嵌套模型
@property (nonatomic,strong) Teacher *teacher;
//嵌套模型数组
@property (nonatomic,strong) NSArray *students;


//声明类方法，但未实现
+ (void)haveMeal:(NSString *)food;
//声明实例方法，但未实现
- (void)singSong:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

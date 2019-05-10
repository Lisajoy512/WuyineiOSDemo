//
//  Student.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
//类方法：参加考试
+ (void)takeExam:(NSString *)exam;
//实例方法：学习知识
- (void)learnKnowledge:(NSString *)course;
@end

NS_ASSUME_NONNULL_END

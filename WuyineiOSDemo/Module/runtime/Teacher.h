//
//  Teacher.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Teacher : NSObject

@property (nonatomic, copy) NSString *country;  //国籍
@property (nonatomic, copy) NSString *province; //省份
@property (nonatomic, copy) NSString *city;     //城市

//实例方法：教书
- (void)teachKnowledge:(NSString *)course;
@end

NS_ASSUME_NONNULL_END

//
//  WYETools.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/13.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYETools : NSObject
// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name ;
@end

NS_ASSUME_NONNULL_END

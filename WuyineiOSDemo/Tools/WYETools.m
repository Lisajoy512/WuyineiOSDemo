//
//  WYETools.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/13.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYETools.h"

@implementation WYETools
// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end

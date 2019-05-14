//
//  NSObject+WYEModel.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/13.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "NSObject+WYEModel.h"
#import <objc/runtime.h>

@implementation NSObject (WYEModel)
+ (instancetype)wye_modelWithDictionary:(NSDictionary *)dictionary{
    
    //创建当前模型对象
    id object = [[self alloc] init];
    //1.获取当前对象的成员变量列表
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    
    //2.遍历ivarList中所有成员变量，以其属性名为key，在字典中查找Value
    for (int i= 0; i<count; i++) {
        //2.1获取成员属性
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)] ;
        
        //2.2截取成员变量名：去掉成员变量前面的"_"号
        NSString *propertyName = [ivarName substringFromIndex:1];
        
        //2.3以属性名为key，在字典中查找value
        id value = dictionary[propertyName];
        
        //3.获取成员变量类型, 因为ivar_getTypeEncoding获取的类型是"@\"NSString\""的形式
        //所以我们要做以下的替换
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];// 替换:
        //3.1去除转义字符：@\"name\" -> @"name"
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        //3.2去除@符号
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        //4.对特殊成员变量进行处理：
        //判断当前类是否实现了协议方法，获取协议方法中规定的特殊变量的处理方式
        NSDictionary *perpertyTypeDic;
        if([self respondsToSelector:@selector(modelContainerPropertyGenericClass)]){
            perpertyTypeDic = [self performSelector:@selector(modelContainerPropertyGenericClass) withObject:nil];
        }
        
        //4.1处理：字典的key与模型属性不匹配的问题，如id->uid
        id anotherName = perpertyTypeDic[propertyName];
        if(anotherName && [anotherName isKindOfClass:[NSString class]]){
            value =  dictionary[anotherName];
        }
        
        //4.2.处理：模型嵌套模型
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass != nil) {
                //将被嵌套字典数据也转化成Model
                value = [modelClass wye_modelWithDictionary:value];
            }
        }
        
        //4.3处理：模型嵌套模型数组
        //判断当前Vaue是一个数组，而且存在协议方法返回了perpertyTypeDic
        if ([value isKindOfClass:[NSArray class]] && perpertyTypeDic) {
            Class itemModelClass = perpertyTypeDic[propertyName];
            //封装数组：将每一个子数据转化为Model
            NSMutableArray *itemArray = @[].mutableCopy;
            for (NSDictionary *itemDic  in value) {
                id model = [itemModelClass wye_modelWithDictionary:itemDic];
                if (model) {
                    [itemArray addObject:model];
                }
            }
            value = itemArray;
        }
        
        //5.使用KVC方法将Vlue更新到object中
        if (value != nil) {
            [object setValue:value forKey:propertyName];
        }
    }
    free(ivarList); //释放C指针
    return object;
}
@end

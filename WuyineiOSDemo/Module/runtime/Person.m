//
//  Person.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
//重写父类方法：处理类方法
+ (BOOL)resolveClassMethod:(SEL)sel{
    
    /**
     BOOL class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp, const char * _Nullable types)
     
     运行时方法：向指定类中添加特定方法实现的操作
     @param cls 被添加方法的类
     @param name selector方法名
     @param imp 指向实现方法的函数指针
     @param types imp函数实现的返回值与参数类型
     @return 添加方法是否成功
     */
    
    if(sel == @selector(haveMeal:)){
        class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(zs_haveMeal:)), "v@");
        return YES;   //添加函数实现，返回YES
    }
    return [class_getSuperclass(self) resolveClassMethod:sel];
}
//重写父类方法：处理实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if(sel == @selector(singSong:)){
        class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(zs_singSong:)), "v@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

///解档操作
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        Class c = self.class;
        while (c && c != [NSObject class]) {
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList(c, &count);
            for (int i = 0; i < count; i++) {
                Ivar ivar = ivars[i];
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
                id value = [self valueForKey:key];
                [self setValue:value forKey:key];
            }
            c = [c superclass];
            free(ivars);
        }
    }
    return self;
}

///归档操作
- (void)encodeWithCoder:(NSCoder *)coder
{
    Class c = self.class;
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            id value = [self valueForKey:key];
            [coder encodeObject:value forKey:key];
        }
        c = [c superclass];
        free(ivars);
    }
}

+ (void)zs_haveMeal:(NSString *)food{
    NSLog(@"%s",__func__);
}

- (void)zs_singSong:(NSString *)name{
    NSLog(@"%s",__func__);
}
@end

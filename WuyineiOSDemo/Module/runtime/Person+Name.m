//
//  Person+Name.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "Person+Name.h"
#import <objc/runtime.h>
@implementation Person (Name)

- (NSString *)name {
    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setName:(NSString *)name {
    return objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY);
}

@end

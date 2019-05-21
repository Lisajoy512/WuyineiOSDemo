//
//  Person+Name.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "Person+Name.h"
#import <objc/runtime.h>
@implementation Person (Other)

- (NSString *)other {
    return objc_getAssociatedObject(self, @selector(other));
}

- (void)setOther:(NSString *)other {
    return objc_setAssociatedObject(self, @selector(other), other, OBJC_ASSOCIATION_COPY);
}

@end

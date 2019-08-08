//
//  WYEMediator.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/28.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEMediator.h"

static WYEMediator *mediator;
@implementation WYEMediator

+ (instancetype)shareInstance {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[WYEMediator alloc] init];
    });
    return mediator;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params {
    NSString *targetClassNSString = [NSString stringWithFormat:@"Target_%@",targetName];
    NSString *actionString = [NSString stringWithFormat:@"Action_%@",actionName];
    
    Class class = NSClassFromString(@"_TtC13WuyineiOSDemo16Target_Animation");
    id target = [[class alloc] init];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) {
        /*
         当target为空时，最好写一个默认的target顶上，这里暂时为空
         */
        return nil;
    }
    
    if([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    }else {
        SEL notFound = NSSelectorFromString(@"notFound");
        if ([target respondsToSelector:notFound]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
        }else {
            /*
             当notFound也无法找到时，这里也应该用默认target顶上，这里暂时为空
             */
            return nil;
        }
    }
}

@end

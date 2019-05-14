//
//  YQMultiThreadObject.m
//  youqu
//
//  Created by 张明 on 2017/1/16.
//  Copyright © 2017年 whsl2014004. All rights reserved.
//

#import "YQMultiThreadObject.h"

/*
 *思想：
   1. 利用NSObject对象 在调用自己没有实现的方法时，会触发forwardInvocation:（前提是要先实现methodSignatureForSelector：方法）来进行消息分发的机制，这样就可以将我们自己自定义的所有子对象（这里可以是各种集合类型，不一定是数组，比如NSSet,NSArray,NSDictionary）未能实现的方法（比如数组的addObject:分发给内部_container对象 ，那这里的_container必须初始化为数组，YQMutableArraya这个类就是例子）分发给系统已实现该方法的对象。
    2.线程安全的实现：
        在forwardInvocation：分发时，用dispatch_barrier_sync（屏障的用法请自行百度）保证任何该对象（_container）的所有方法都串行执行。
 */

@implementation YQMultiThreadObject
- (id)init
{
    self = [super init];
    if (self) {
        _dispatchQueue = dispatch_queue_create("COM.YQ.MUTABLEARRAY", NULL);
    }
    return self;
}

- (void)dealloc
{
    _dispatchQueue = nil;
    _container = nil;
}
#pragma mark - method over writing
- (NSString *)description
{
    return _container.description;
}

#pragma mark - public method
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [[_container class] instanceMethodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSMethodSignature *sig = anInvocation.methodSignature;
    const char *returnType = sig.methodReturnType;

    /** 获取调度方法的返回值，如果是void型方法则使用异步调度，如果是getter类型的则使用同步调度，可以略微的提升性能。
     */
    if (!strcmp(returnType, "v")) {
        //setter
        dispatch_barrier_async(_dispatchQueue, ^{
            [anInvocation invokeWithTarget:_container];
        });
    }
    else {
        //getter
        dispatch_barrier_sync(_dispatchQueue, ^{
            [anInvocation invokeWithTarget:_container];
        });
    }
}

@end

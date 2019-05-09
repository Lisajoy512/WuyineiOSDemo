//
//  UIViewController+Logger.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/9.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "UIViewController+Logger.h"
#import "WYEHook.h"
@implementation UIViewController (Logger)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 通过 @selector 获得被替换和替换方法的 SEL，作为 SMHook:hookClass:fromeSelector:toSelector 的参数传入
        SEL fromSelectorAppear = @selector(viewWillAppear:);
        SEL toSelectorAppear = @selector(hook_viewWillAppear:);
        [WYEHook hookClass:self fromSelector:fromSelectorAppear toSelector:toSelectorAppear];
        
        SEL fromSelectorDisappear = @selector(viewWillDisappear:);
        SEL toSelectorDisappear = @selector(hook_viewWillDisappear:);
        
        [WYEHook hookClass:self fromSelector:fromSelectorDisappear toSelector:toSelectorDisappear];
    });
}

- (void)hook_viewWillAppear:(BOOL)animated {
    // 先执行插入代码，再执行原 viewWillAppear 方法
    [self insertToViewWillAppear];
    
    /**
    //乍一看，这里容易理解成循环递归调用。但其实要正确理解这个方法交换的过程：
     1、程序首先调用viewWillAppear方法，但其实已经被替换成hook_viewWillAppear了。所以执行到hook_viewWillAppear
     2、执行完insertToViewWillAppear这个方法后，调用hook_viewWillAppear，但这个方法其实已经被替换成viewWillAppear了。
    */
    [self hook_viewWillAppear:animated];
}
- (void)hook_viewWillDisappear:(BOOL)animated {
    // 执行插入代码，再执行原 viewWillDisappear 方法
    [self insertToViewWillDisappear];
    [self hook_viewWillDisappear:animated];
}

- (void)insertToViewWillAppear {
    // 在 ViewWillAppear 时进行日志的埋点
    NSLog(@"hook到  %@ will appear",NSStringFromClass([self class]));
}
- (void)insertToViewWillDisappear {
    // 在 ViewWillDisappear 时进行日志的埋点
    // 在 ViewWillAppear 时进行日志的埋点
    NSLog(@"hook到  %@ will disappear",NSStringFromClass([self class]));
}
@end

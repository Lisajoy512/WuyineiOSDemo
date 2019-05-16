//
//  KVCandKVOViewController.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/15.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, assign)  CGFloat price;
@property (nonatomic, copy)  NSString *country;
@property (nonatomic, copy)  NSString *province;
@property (nonatomic, copy)  NSString *city;
@property (nonatomic, copy)  NSString *district;
@end

@interface KVCandKVOViewController : WYEBaseViewController
@end

NS_ASSUME_NONNULL_END

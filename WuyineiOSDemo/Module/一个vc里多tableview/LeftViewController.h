//
//  LeftViewController.h
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/9.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^cellClickBlock)(NSInteger selectIndex);

@interface LeftViewController : WYEBaseTableViewController
@property (nonatomic,copy) cellClickBlock clickBlock;
@end

NS_ASSUME_NONNULL_END

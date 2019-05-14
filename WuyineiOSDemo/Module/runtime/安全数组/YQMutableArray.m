//
//  YQMutableArray.m
//  youqu
//
//  Created by 张明 on 2017/1/16.
//  Copyright © 2017年 whsl2014004. All rights reserved.
//

#import "YQMutableArray.h"

@implementation YQMutableArray
- (id)init
{
    self = [super init];
    if (self) {
        self.container = [NSMutableArray array];
    }
    return self;
}

@end

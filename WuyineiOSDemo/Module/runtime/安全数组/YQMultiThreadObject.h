//
//  YQMultiThreadObject.h
//  youqu
//
//  Created by 张明 on 2017/1/16.
//  Copyright © 2017年 whsl2014004. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQMultiThreadObject : NSObject
{
    dispatch_queue_t _dispatchQueue;
    NSObject *_container;
}
@property (nonatomic, strong) NSObject *container;
@end

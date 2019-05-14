//
//  YQMutableArray.h
//  youqu
//
//  Created by 张明 on 2017/1/16.
//  Copyright © 2017年 whsl2014004. All rights reserved.
//

#import "YQMultiThreadObject.h"

@protocol YQMutableArrayProtocol
@optional
- (id)lastObject;
- (id)objectAtIndex:(NSUInteger)index;

- (NSUInteger)count;

- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeAllObjects;
- (void)addObjectsFromArray:(NSArray *)array;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)removeObject:(id)anObject;
- (NSArray *)sortedArrayUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors;
- (NSArray *)filteredArrayUsingPredicate:(NSPredicate *)predicate;
- (void)makeObjectsPerformSelector:(SEL)aSelector NS_SWIFT_UNAVAILABLE("Use enumerateObjectsUsingBlock: or a for loop instead");
@end

@interface YQMutableArray : YQMultiThreadObject <YQMutableArrayProtocol,NSCopying, NSMutableCopying, NSSecureCoding, NSFastEnumeration>

@end

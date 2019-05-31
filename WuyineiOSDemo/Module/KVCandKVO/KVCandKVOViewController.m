//
//  KVCandKVOViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/15.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "KVCandKVOViewController.h"

@implementation Book

@end

@interface KVCandKVOViewController (){
}
@property (nonatomic,copy) NSString *name;

@end

@implementation KVCandKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KVC and KVO";
    self.dataArray = @[@"KVC赋值",
                       @"KVC处理集合 @avg、 @count、@max、@min、@sum",
                       @"KVC对象运算符 distinctUnionOfObjects、unionOfObjects",
                       @"KVC字典转模型",
                       @"KVC的其他运用场景",
                       @"手动KVO 具体看代码",
                       @"KVO实战"
                       ];
}

+ (BOOL)accessInstanceVariablesDirectly{
    //为NO的时候KVC只会查询setter和getter这一层
    return NO;
    /*
     默认返回YES
     会按照_key，_iskey，key，iskey的顺序搜索成员并进行赋值操作
     */
    //注意是类方法，实测写成实例方法时无效
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            //通过KVC赋值name
            [self setValue:@"xiaoming" forKey:@"name"];
            //通过KVC取值name打印
            NSLog(@"obj的名字是%@", [self valueForKey:@"name"]);
            break;
        }
        case 1:
        case 2:{
            Book *book1 = [Book new];
            book1.name = @"The Great Gastby";
            book1.price = 10;
            Book *book2 = [Book new];
            book2.name = @"Time History";
            book2.price = 20;
            Book *book3 = [Book new];
            book3.name = @"Wrong Hole";
            book3.price = 30;
            Book *book4 = [Book new];
            book4.name = @"Wrong Hole";
            book4.price = 20;
            
            NSArray* arrBooks = @[book1,book2,book3,book4];
            NSNumber* sum = [arrBooks valueForKeyPath:@"@sum.price"];
            NSLog(@"sum:%f",sum.floatValue);
            NSNumber* avg = [arrBooks valueForKeyPath:@"@avg.price"];
            NSLog(@"avg:%f",avg.floatValue);
            NSNumber* count = [arrBooks valueForKeyPath:@"@count"];
            NSLog(@"count:%f",count.floatValue);
            NSNumber* min = [arrBooks valueForKeyPath:@"@min.price"];
            NSLog(@"min:%f",min.floatValue);
            NSNumber* max = [arrBooks valueForKeyPath:@"@max.price"];
            NSLog(@"max:%f",max.floatValue);
            
            NSLog(@"去重distinctUnionOfObjects");
            NSArray* arrDistinct = [arrBooks valueForKeyPath:@"@distinctUnionOfObjects.price"];
            for (NSNumber *price in arrDistinct) {
                NSLog(@"%f",price.floatValue);
            }
            NSLog(@"不去重unionOfObjects");
            NSArray* arrUnion = [arrBooks valueForKeyPath:@"@unionOfObjects.price"];
            for (NSNumber *price in arrUnion) {
                NSLog(@"%f",price.floatValue);
            }
        }
        case 3: {
            Book *add = [Book new];
            add.country = @"China";
            add.province = @"Guang Dong";
            add.city = @"Shen Zhen";
            add.district = @"Nan Shan";
            
            //模型转字典
            NSArray *arr = @[@"country",@"province",@"city",@"district"];
            NSDictionary* dict = [add dictionaryWithValuesForKeys:arr]; //把对应key所有的属性全部取出来
            NSLog(@"%@",dict);
            
            //字典转模型
            NSDictionary* modifyDict = @{@"country":@"USA",@"province":@"california",@"city":@"Los angle"};
            [add setValuesForKeysWithDictionary:modifyDict];            //用key Value来修改Model的属性
            NSLog(@"country:%@  province:%@ city:%@",add.country,add.province,add.city);
        }
        case 4:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KVC运用场景" message:@"1.动态取值和设置\n2.访问和修改私有变量\n3.Model和字典的互换\n4.操作集合\n5.实现高阶消息的传递" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case 5: {
            // for manual KVO - age
//            - (int) age
//            {
//                return age;
//            }
//
//            - (void) setAge:(int)theAge
//            {
//                [self willChangeValueForKey:@"age"];
//                age = theAge;
//                [self didChangeValueForKey:@"age"];
//            }
//
//            + (BOOL) automaticallyNotifiesObserversForKey:(NSString *)key {
//                if ([key isEqualToString:@"age"]) {
//                    return NO;
//                }
//
//                return [super automaticallyNotifiesObserversForKey:key];
//            }

            break;
        }
        case 6: {
            [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
            self.name = @"new";
            break;
        }
            
        default:
            break;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"])
    {
        Class classInfo = (Class)object;
        NSString *className = [NSString stringWithCString:object_getClassName(classInfo)
                                                  encoding:NSUTF8StringEncoding];
        NSLog(@" >> class: %@, name changed", className);
        NSLog(@" old age is %@", [change objectForKey:@"old"]);
        NSLog(@" new age is %@", [change objectForKey:@"new"]);
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"name"];
}

@end

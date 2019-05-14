//
//  RuntimeDemoViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "RuntimeDemoViewController.h"
#import "Person+Name.h"
#import "Student.h"
#import "Teacher.h"
#import <objc/runtime.h>
#import "WYETools.h"
#import "YQMutableArray.h"
@interface RuntimeDemoViewController ()
@property (nonatomic,strong) Student *student;
@property (nonatomic,strong) Teacher *teacher;
@property (nonatomic,copy) NSString *privateIvar;
@end

@implementation RuntimeDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"0 消息动态解析",
                       @"1 消息接收者转发",
                       @"2 消息转发",
                       @"3 分类增加属性",
                       @"4 获取类相关信息",
                       @"5 方法大量调用直接走IMP，绕开消息发送过程",
                       @"6 自动归档和解档",
                       @"7 修改私有属性的值",
                       @"8 字典与模型的转换",
                       @"9 创建线程安全的数组"
                       ];
}


#pragma mark -- 消息接收者转发
//重定向类方法：返回类，不能返回[self class]，否则死循环
+ (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(takeExam:)) {
        return [Student class];
    }
    return [super forwardingTargetForSelector:aSelector];
}
//重定向实例方法：返回类的实例，不能返回self，否则死循环
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(learnKnowledge:)) {
        return self.student;
    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark -- 消息转发
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    //1.从anInvocation中获取消息
    SEL sel = anInvocation.selector;
    //2.判断Student方法是否可以响应应sel
    if ([self.teacher respondsToSelector:sel]) {
        //2.1若可以响应，则将消息转发给其他对象处理
        [anInvocation invokeWithTarget:self.teacher];
    }else{
        //2.2若仍然无法响应，则报错：找不到响应方法
        [self doesNotRecognizeSelector:sel];
    }
}

/**注意：消息转发一定需要重写这个方法！！！需要从这个方法中获取的信息来创建NSInvocation对象，因此我们必须重写这个方法，为给定的selector提供一个合适的方法签名。
 */
- (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}

//获取类的信息
- (void)getDetailClassInfo {
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"PropertyName(%d): %@",i,[NSString stringWithUTF8String:propertyName]);
    }
    free(propertyList);
    
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i= 0; i<count; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSLog(@"Ivar(%d): %@", i, [NSString stringWithUTF8String:ivarName]);
    }
    free(ivarList);
    
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Method method = methodList[i];
        SEL mthodName = method_getName(method);
        NSLog(@"MethodName(%d): %@",i,NSStringFromSelector(mthodName));
    }
    free(methodList);
    
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (int i=0; i<count; i++) {
        Protocol *protocal = protocolList[i];
        const char *protocolName = protocol_getName(protocal);
        NSLog(@"protocol(%d): %@",i, [NSString stringWithUTF8String:protocolName]);
    }
    free(protocolList);
}
/**
 IMP作为函数指针，指向方法的实现。通过它，我们可以绕开发送消息的过程来提高函数调用的效率。当我们需要持续大量重复调用某个方法的时候，会十分有用。
 */
//- (void)highFrequencyFuncInvoke {
//    void (*setter)(id, SEL, BOOL);
//    int i;
//
//    setter = (void (*)(id, SEL, BOOL))[target methodForSelector:@selector(setFilled:)];
//    for ( i = 0 ; i < 1000 ; i++ )
//        setter(targetList[i], @selector(setFilled:), YES);
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            /**
             1.消息动态解析，就是Person其实并未实现haveMeal:和singSong:方法，
             2.但Person实现了resolveClassMethod:和resolveInstanceMethod:
             3.方法当解析到接收 sel == @selector(haveMeal:)，就添加新方法class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(zs_haveMeal:)), "v@");
             4.将sel指向的IMP指向class_getMethodImplementation(object_getClass(self), @selector(zs_haveMeal:))
             5.因此最终执行的是zs_haveMeal方法
             */
            [Person haveMeal:@"have meal"];
            Person *p = [[Person alloc] init];
            [p singSong:@"sing song"];
        }
            break;
        case 1: {
            [RuntimeDemoViewController performSelector:@selector(takeExam:) withObject:@"语文"];
            self.student = [[Student alloc] init];
            [self performSelector:@selector(learnKnowledge:) withObject:@"数学"];
        }
            break;
        case 2: {
            self.teacher = [[Teacher alloc] init];
            [self performSelector:@selector(teachKnowledge:) withObject:@"天文学"];
        }
            break;
        case 3: {
            Person *p = [[Person alloc] init];
            p.name = @"新名字";
            NSLog(@"p.name = %@",p.name);
        }
            break;
        case 4: {
            [self getDetailClassInfo];
        }
            break;
        case 5: {
//            [self highFrequencyFuncInvoke];
        }
            break;
        case 6: {
            Person *p = [[Person alloc] init];
            p.name = @"用来测试归档和解档";
            NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:p];
            [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"person"];
            [[NSUserDefaults standardUserDefaults]  synchronize];
            
            NSData *unarchiveData = [[NSUserDefaults standardUserDefaults] objectForKey:@"person"];
            if (unarchiveData) {
                Person *p = [NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData];
                p.name = @"测试归档和解档";
                NSLog(@"%@,p.name = %@",p,p.name);
            }
        }
            break;
        case 7: {
            self.privateIvar = @"旧私有名";
            unsigned int count;
            Ivar *ivarList = class_copyIvarList([self class], &count);
            for (int i= 0; i<count; i++) {
                //第二步：获取每个属性名
                Ivar ivar = ivarList[i];
                const char *ivarName = ivar_getName(ivar);
                NSString *propertyName = [NSString stringWithUTF8String:ivarName];
                if ([propertyName isEqualToString:@"_privateIvar"]) {
                    //第三步：匹配到对应的属性，然后修改；注意属性带有下划线
                    object_setIvar(self, ivar, @"新私有名");
                }
            }
            NSLog(@"privateIvar: %@",[self valueForKey:@"privateIvar"]);
        }
            break;
        case 8: {
            NSDictionary *dic = [WYETools readLocalFileWithName:@"test"];
            //字典转模型
            Person *person = [Person wye_modelWithDictionary:dic];
            Student *student = person.students[0];
            NSLog(@"%@",student.name);
        }
            break;
        case 9: {
            YQMutableArray *arr = [[YQMutableArray alloc] init];
            Person *p = [[Person alloc] init];
            [arr addObject:p];
            NSLog(@"arr.count = %lu",(unsigned long)arr.count);
        }
            break;
        default:
            break;
    }
}

@end

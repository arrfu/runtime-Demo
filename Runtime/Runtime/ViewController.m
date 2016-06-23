//
//  ViewController.m
//  Runtime
//
//  Created by suhc on 16/3/16.
//  Copyright © 2016年 arrfu. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import <objc/runtime.h>
#import "Student+Category.h"
#import "Student+test.h"

#import "AppDelegate.h"

@interface ViewController (){
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addExtentionProperty];// 动态为Category扩展加属性
    
    [self addExtentionWithBlockProperty];// 动态为 Student 添加的分类扩展属性(扩展一个block属性)
    
    [self exchangeMethod]; // 动态交换方法实现
    
    [self addMethod]; // 动态添加方法
    
    [self changeVariable]; // 动态变量控制
    
}

/**
 *  动态变量控制
 */
- (void)changeVariable{
    Student *student = [Student new];
    student.name = @"乔布斯";
    NSLog(@"%@",student.name);
    
    unsigned int count;
    Ivar *ivar = class_copyIvarList([Student class], &count); // 要获取对象的成员变量，可以通过class_copyIvarList方法来获取
    for (int i = 0; i < count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var); // 通过ivar_getName来获取成员变量的名称
        NSString *name = [NSString stringWithCString:varName encoding:NSUTF8StringEncoding];
        if ([name isEqualToString:@"_name"]) {
            object_setIvar(student, var, @"Steve Jobs"); // 通过 object_setIvar 设置该成员变量
            break;
        }
        
    }
    
    NSLog(@"%@",student.name);
}

/**
 *  动态添加方法
 */
- (void)addMethod{
    Student *student = [Student new];
    BOOL addSuccess = class_addMethod([Student class], @selector(join), (IMP)happyNewYear, "v@:");// "v@:" 指的是什么？
    if (addSuccess) {
        [student performSelector:@selector(join)];
    }
}


void happyNewYear(id self,SEL _cmd){
    NSLog(@"新年快乐");
}

-(void)join{
    NSLog(@"in the join %s",__func__);
}

/**
 *  动态为Category扩展加属性 (NSString属性)
 */
- (void)addExtentionProperty{
    Student *student = [Student new];
    student.firstName = @"Steve";
    
    NSLog(@"firstName = %@",student.firstName);
}

/**
 * 动态为 Student 添加的分类扩展属性(扩展一个block属性)
 */
-(void)addExtentionWithBlockProperty{
    Student *student = [[Student alloc] init];
    student.myBlock = ^{
        NSLog(@"in myBlock");
    };
    
    student.myBlock();
    
    student.testBlock = ^(NSString *str){
        NSLog(@"in testBlock: %@",str);
    };
    
    student.testBlock(@"传入一个参数test");
    
    student.myBlock(); // 若在分类扩展中多个属性公用一个关联key，那么属性会错乱。
    
}

/**
 *  动态交换方法实现
 */
- (void)exchangeMethod{
    NSLog(@"---------交换方法实现前---------");
    Student *student = [Student new];
    student.name = @"乔布斯";
    [student eat];
    [student sleep];
    
    NSLog(@"---------交换方法实现后---------");
    Method method1 = class_getInstanceMethod([Student class], @selector(eat));
    Method method2 = class_getInstanceMethod([Student class], @selector(sleep));
    method_exchangeImplementations(method1, method2);
    [student eat];
    [student sleep];
}

@end

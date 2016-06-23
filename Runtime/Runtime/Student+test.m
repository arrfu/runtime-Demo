//
//  Student+test.m
//  Runtime
//
//  Created by hao123 on 16/6/7.
//  Copyright © 2016年
//  iOS的category是不能扩展存储属性的，但是我们可以通过运行时关联来扩展“属性”
//  总结： 实质上就是通过objc_getAssociatedObject取得关联的值，通过objc_setAssociatedObject设置关联。

// 注意：若在分类扩展中多个属性公用一个关联key，那么属性会错乱。

#import "Student+test.h"
#import <objc/runtime.h>

@implementation Student (test)

// 用一个静态变量作为myBlock 的关联key
const void *s_MyBlockKey = "s_MyBlockKey";

// 用一个静态变量作为TestBlock 的关联key
const void *s_TestBlockKey = @"s_TestBlockKey";

/**
 * 重写myBlock 的set方法
 */
-(void)setMyBlock:(MyBlock)myBlock{
    objc_setAssociatedObject(self, s_MyBlockKey, myBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


/**
 * 重写myBlock 的get方法
 */
-(MyBlock)myBlock{
    return objc_getAssociatedObject(self, s_MyBlockKey);
}

/**
 * 重写testBlock 的set方法
 */
-(void)setTestBlock:(TestBlock)testBlock{
    objc_setAssociatedObject(self, s_TestBlockKey, testBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 * 重写testBlock 的get方法
 */
-(TestBlock)testBlock{
    return objc_getAssociatedObject(self, s_TestBlockKey);
}
@end

//
//  Student+test.h
//  Runtime
//
//  Created by hao123 on 16/6/7.
//  Copyright © 2016年 arrfu. All rights reserved.
//

#import "Student.h"

typedef void (^MyBlock)();

typedef void (^TestBlock)(NSString*);

@interface Student (test)

@property (nonatomic,copy)MyBlock myBlock; // 添加一个block属性

@property (nonatomic,copy)TestBlock testBlock; // 添加一个带参数的block属性

@end

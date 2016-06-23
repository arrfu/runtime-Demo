# runtime-Demo
runtime 的基本用法

相关runtime方法：

<pre>
1.Ivar *ivar = class_copyIvarList([Student class], &count); // 要获取对象的成员变量，可以通过class_copyIvarList方法来获取

2.const char *varName = ivar_getName(var); // 通过ivar_getName来获取成员变量的名称

3.object_setIvar(student, var, @"Steve Jobs"); // 通过 object_setIvar 设置该成员变量

4.BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)  //  动态添加方法

5.Method method1 = class_getInstanceMethod([Student class], @selector(eat)); // 获取该方法

6.method_exchangeImplementations(method1, method2);  // 交换方法
</pre>

使用例子：
<pre>
1.[self addExtentionProperty];// 动态为Category扩展加属性
    
2.[self addExtentionWithBlockProperty];// 动态为 Student 添加的分类扩展属性(扩展一个block属性)
    
3.[self exchangeMethod]; // 动态交换方法实现
    
4.[self addMethod]; // 动态添加方法
    
5.[self changeVariable]; // 动态变量控制
</pre>

具体代码实现，请看demo代码。


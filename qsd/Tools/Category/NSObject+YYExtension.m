//
//  NSObject+YYExtension.m
//  RumtimeDemo
//
//  Created by YeYiFeng on 16/12/3.
//  Copyright © 2016年 YeYiFeng. All rights reserved.
//

#import "NSObject+YYExtension.h"
#import <objc/runtime.h>

@implementation NSObject (YYExtension)
//归档必须实现的方法
- (void)encodeWithCoder:(NSCoder *)coder
{
    // 归档 OC对象 每一个属性为键值对
    //    [coder encodeObject:self.name forKey:@"name"];
    //    [coder encodeDouble:self.height forKey:@"height"];
    //    [coder encodeInteger:self.age forKey:@"age"];
    
    unsigned int count = 0;
    Ivar *ivars =  class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++)
    {
        //从列表中取出Ivars
        Ivar ivar = ivars[i];
        const char *name =  ivar_getName(ivar);
        NSString *key=[NSString stringWithUTF8String:name];
        // 归档
        [coder encodeObject: [self valueForKey:key] forKey:key];
        
        
    }
    free(ivars); //释放
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self=[self init])
    {
        //解档
        
        unsigned int count = 0;
        Ivar *ivars=class_copyIvarList([self class], &count);
        for (int i=0; i<count; i++)
        {
            //取出ivar
            Ivar ivar=ivars[i];
            //取出名称
            const char *name = ivar_getName(ivar);
            NSString *KEY=[NSString stringWithUTF8String:name];
            //接档
            id value=[coder decodeObjectForKey:KEY];
            //设置到自己的属性上去
            [self setValue:value forKey:KEY];
        }
        
        free(ivars);
        
    }
    return self;
}

@end

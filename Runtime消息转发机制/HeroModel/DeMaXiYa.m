//
//  DeMaXiYa.m
//  Runtime消息转发机制
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "DeMaXiYa.h"
#import "HanBingSheShou.h"
#import <objc/message.h>

@implementation DeMaXiYa
{
    HanBingSheShou * _hanbing;
}
@dynamic intro;

-(instancetype)init{
    self = [super init];
    if (self) {
       _hanbing  = [[HanBingSheShou alloc] init];
    }
    return self;
}


/**
 找不到方法，开始转发
 
 @param sel 方法名
 @return 是否可以转发
 */
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSString * selName = NSStringFromSelector(sel);
    if ([selName isEqualToString:@"setIntro:"]) {
        class_addMethod(self, sel, (IMP)setIntro,"v@:@");
        return YES;
    }
    
    if ([selName isEqualToString:@"getIntro"]) {
        class_addMethod(self, sel, (IMP)getIntro,"@@:");
    }
    
    return [super resolveInstanceMethod:sel];
}



/**
 实现对setIntro的转发
 
 @param self 对象
 @param cmd 方法
 @param value 传入的值
 */
void setIntro(id self, SEL cmd,id value){
    NSString * intro = value;
    NSArray  * introArray = [intro componentsSeparatedByString:@","];
    DeMaXiYa * dema  =   (DeMaXiYa *)self;
    dema.name     = introArray[0];
    dema.category = introArray[1];
    dema.beiDong  = introArray[2];
    NSLog(@"name:%@,category:%@,beiDong:%@",dema.name,dema.category,dema.beiDong);
}

/**
 实现对getIntro的转发
 
 @param self 对象
 @param cmd 方法
 @return 返回值
 */
id getIntro(id self,SEL cmd){
    DeMaXiYa * dema  =   (DeMaXiYa *)self;
    return [NSString stringWithFormat:@"%@%@%@",dema.name,dema.category,dema.beiDong];
}



/**
 如果resolveInstanceMethod没有转发，返回NO。则进行forwardingTargetForSelector方法调用
 
 @param aSelector 方法
 @return 返回转发的对象
 */
-(id)forwardingTargetForSelector:(SEL)aSelector{
    NSString * selName =  NSStringFromSelector(aSelector);
    if ([selName isEqualToString:@"Q"]) {
        return _hanbing;
    }
    return [super forwardingTargetForSelector:aSelector];
}


/**
 如果forwardingTargetForSelector返回未nil，则调用
 
 @param aSelector 调用方法
 @return 签名
 */
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *sign = nil;
    if ([NSStringFromSelector(aSelector) isEqualToString:@"R"]) {
        sign = [self methodSignatureForSelector:@selector(R:)];
    }else{
        sign = [super methodSignatureForSelector:aSelector];
    }
    return sign;  //如果到这里还有找到转发的消息，程序就crash了。
}


/**
 现在我们有了方法的签名，现在只需要将方法打包转发
 
 @param anInvocation  通过签名得到的方法转发对象
 */
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    if ([NSStringFromSelector(anInvocation.selector) isEqualToString:@"R"]) {
        [anInvocation setTarget:self];
        [anInvocation setSelector:@selector(R:)];
        NSString * name = @"流浪法师";
        //第一个和第二个参数是target和sel
        [anInvocation setArgument:&name atIndex:2];
        [anInvocation retainArguments];
        [anInvocation invoke];
        
        NSString * returnStr = [NSString stringWithFormat:@"%@死于大招之下",name];
        [anInvocation setReturnValue:&returnStr];
        [anInvocation getReturnValue:&returnStr];
    }
    
}


-(NSString *)R:(NSString *)emery{
    return nil;
}

@end

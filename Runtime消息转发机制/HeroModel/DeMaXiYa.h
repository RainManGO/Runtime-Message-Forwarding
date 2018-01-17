//
//  DeMaXiYa.h
//  Runtime消息转发机制
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeMaXiYa : NSObject

//intro这个属性为动态属性，不分配setter getter ;
@property (nonatomic,copy)NSString * intro;

@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * category;
@property (nonatomic,copy)NSString * beiDong;

-(void)Q;
-(NSString *)R;
@end

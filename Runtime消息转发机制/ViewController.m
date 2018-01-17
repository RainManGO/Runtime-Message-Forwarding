//
//  ViewController.m
//  Runtime消息转发机制
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ViewController.h"
#import "DeMaXiYa.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DeMaXiYa * ZYDema =  [[DeMaXiYa alloc]init];
    ZYDema.intro = @"德玛,上单,回血";
    [ZYDema Q];
    NSString * retunR = [ZYDema R];
    NSLog(@"%@",retunR);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

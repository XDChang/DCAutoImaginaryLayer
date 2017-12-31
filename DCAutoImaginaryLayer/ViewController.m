//
//  ViewController.m
//  DCAutoImaginaryLayer
//
//  Created by 徐德昌 on 2017/12/31.
//  Copyright © 2017年 徐德昌. All rights reserved.
//

#import "ViewController.h"
#import "DCAutoImaginaryLayer.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:43/255.0f green:43/255.0f blue:43/255.0f alpha:1];
    DCAutoImaginaryLayer *processView = [[DCAutoImaginaryLayer alloc]initWithFrame:CGRectMake(30, 200, 320, 320)];
    processView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:processView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

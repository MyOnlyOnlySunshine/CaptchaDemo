//
//  ViewController.m
//  CaptchaDemo
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 ChangChang. All rights reserved.
//

#import "ViewController.h"
#import "CaptchaView.h"

@interface ViewController ()
@property(nonatomic,strong)CaptchaView *captchaV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captchaV = [[CaptchaView alloc]initWithFrame:CGRectMake(40, 40, 80, 40)];
    [self.view addSubview:self.captchaV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  VipViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "VipViewController.h"

@interface VipViewController ()

@end

@implementation VipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"黄金会员";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight - 44)];
    
    [self.view addSubview:scroll];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth * 2.5)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    NSString *s = [[NSBundle mainBundle]pathForResource:@"会员等级说明" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:s];
    
    scroll.contentSize = imageView.frame.size;
    [scroll addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  HelpViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"帮助";
    
    [self setContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)setContent
{
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    [self.view addSubview:scroll];
    
    NSData *data = [NSData dataWithContentsOfURL:_url];
    UIImage *image = [UIImage imageWithData:data];
    
    self.imageView = [[UIImageView alloc]initWithImage:image];
    _imageView.backgroundColor = [UIColor redColor];
    [scroll addSubview:_imageView];
    scroll.contentSize = _imageView.frame.size;
    
}

@end

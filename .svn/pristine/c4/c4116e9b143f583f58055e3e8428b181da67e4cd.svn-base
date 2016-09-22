//
//  ExplainViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ExplainViewController.h"

@interface ExplainViewController ()

@end

@implementation ExplainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"使用说明";
    
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

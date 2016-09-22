//
//  CategoryViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CategoryViewController.h"
#import "MultilevelMenu.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"分类";

    MultilevelMenu * view=[[MultilevelMenu alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, SCREEN_HEIGHT-64-49)];
    
    
    view.needToScorllerIndex=0;
    
    view.isRecordLastScroll=YES;
    view.delegate = self;
    view.tag = 500;
    [self.view addSubview:view];
    
    [view getRightData:0];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  HomeSecondViewController.m
//  JingFengMall
//
//  Created by len on 16/5/6.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeSecondViewController.h"
#import "HomeSecondViewMenu.h"
@interface HomeSecondViewController ()

@end

@implementation HomeSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"分类";
    
    HomeSecondViewMenu * view=[[HomeSecondViewMenu alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, SCREEN_HEIGHT-64-49)];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

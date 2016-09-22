//
//  SubscribeViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SelectServicerViewController.h"

@interface SubscribeViewController ()

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约";
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirm:(id)sender {
    
    SelectServicerViewController *select = [[SelectServicerViewController alloc]init];
    
    [self.navigationController pushViewController:select animated:YES];
}

@end

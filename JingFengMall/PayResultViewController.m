//
//  PayResultViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "PayResultViewController.h"

@interface PayResultViewController ()

@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backToHomeView:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end

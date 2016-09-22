//
//  AccountSafeViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "AccountSafeViewController.h"
#import "ForgetPassViewController.h"

@interface AccountSafeViewController ()

@end

@implementation AccountSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户安全";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePhone:(UITapGestureRecognizer *)sender {
    
    
}


- (IBAction)changePassword:(UITapGestureRecognizer *)sender {
    
    ForgetPassViewController *forget = [[ForgetPassViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
    
}

@end

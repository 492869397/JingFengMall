//
//  SelectBillViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/9.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "SelectBillViewController.h"
#import "CommitOrderViewController.h"

@interface SelectBillViewController ()

@end

@implementation SelectBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择发票";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirm:(id)sender {
    
    if ([_bill.text isEqualToString:@""]) {
        Toast *toa = [Toast makeText:@"请输入个人或单位名称"];
        [toa showWithType:ShortTime];
        return;
    }
    
    CommitOrderViewController* dele = (CommitOrderViewController*)_delegate;
    
    dele.bill = _bill.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end

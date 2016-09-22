//
//  HomeSucceedViewController.m
//  JingFengMall
//
//  Created by len on 16/5/11.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeSucceedViewController.h"
#import "HomeAssessViewController.h"

@interface HomeSucceedViewController ()

- (IBAction)backBtn:(id)sender;


@end

@implementation HomeSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价成功";
    self.Aselbl.text = _lableStr;
    if ([_lableStr isEqualToString:@"评价失败"]) {
        [_AseImageView setImage:[UIImage imageNamed:@"icon32.png"]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
    NSLog(@"back");
    [self.navigationController popToRootViewControllerAnimated:YES];

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

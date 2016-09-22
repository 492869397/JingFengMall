//
//  CarMassageViewController.m
//  JingFengMall
//
//  Created by len on 16/1/26.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "CarMassageViewController.h"
#import "PhotoViewController.h"

@interface CarMassageViewController ()

@end

@implementation CarMassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆信息";
    
    UIEdgeInsets edge = UIEdgeInsetsMake(20, 20, 20, 20);
    UIImage *backgroundImage = [[UIImage imageNamed:@"按钮_03"]resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    [self.button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    self.cheleixing.delegate = self;
    self.cheleixingPic.image = [UIImage imageNamed:@"car_1"];
    self.carList = @[@"轿车",@"货车",@"电动车",@"三轮车",@"其他"];
    
    self.brand.delegate = self;
    self.carNumber.delegate = self;
    self.carColor.delegate = self;
    self.carType.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma pickerView代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.carList.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.carList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *car = [NSString stringWithFormat:@"car_%ld",(long)row+1];
    self.cheleixingPic.image = [UIImage imageNamed:car];
    self.carTypeNumber = row;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirm:(id)sender {
    if ([self isMassageFilled]) {
        [self updateRegisterMassage];
    }
    else
    {
        Toast *toast = [Toast makeText:@"请填写完整基本信息"];
        [toast showWithType:ShortTime];
    }
}

-(BOOL)isMassageFilled
{
    BOOL a = self.carColor.text.length >= 1;
    BOOL b = self.brand.text.length > 1;
    BOOL c = self.carType.text.length > 1;
    BOOL d = self.carNumber.text.length >= 7;
    return (a && b && c && d);
}

//提交注册信息
-(void)updateRegisterMassage
{    
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"];
    NSString *carBrand = [self.brand.text stringByAppendingString:self.carType.text];
    [para setObject:phoneNumber forKey:ACCOUNT];
    [para setObject:self.carList[_carTypeNumber] forKey:@"carType"];
    [para setObject:carBrand forKey:@"carBrand"];
    [para setObject:self.carNumber.text forKey:@"carNumber"];
    [para setObject:self.carColor.text forKey:@"carColor"];
    
    Network *net = [[Network alloc]init];
    [net accessNetUrl:URL_DIVERREGIST parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            PhotoViewController *view = [[PhotoViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }else
        {
            Toast *toast = [Toast makeText:@"注册失败,请检查输入信息"];
            [toast showWithType:ShortTime];
        }
    }];
}

@end

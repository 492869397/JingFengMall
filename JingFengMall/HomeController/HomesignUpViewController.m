//
//  HomesignUpViewController.m
//  JingFengMall
//
//  Created by len on 16/5/19.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomesignUpViewController.h"
#define URL @"http://123.57.28.11:8080/jfsc_app/createEmployee.do"
@interface HomesignUpViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNum;
@property (strong, nonatomic) IBOutlet UITextField *txtAuthCode;
@property (strong, nonatomic) IBOutlet UIButton *GainBtn;
@property(strong,nonatomic)NSTimer *timer;
@property(assign,nonatomic)NSInteger time;
@property(copy,nonatomic)NSString *code;


@end

@implementation HomesignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//相关
- (IBAction)AssertBtn:(id)sender{
}
//获取
- (IBAction)GainBtn:(id)sender {
    
    if ([self validateMobile:self.txtPhoneNum.text]) {
        
        [self getVerifyFromNet];
        [_GainBtn setEnabled:NO];
        self.time = 60;
        [_GainBtn setTitle:@"60s后重试" forState:UIControlStateDisabled];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(buttonTimeLimit) userInfo:nil repeats:YES];
    }

}
-(void)buttonTimeLimit
{
    self.time -= 1;
    if (self.time <= 0) {
        [_GainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_GainBtn setEnabled:YES];
        [self.timer invalidate];
        self.time = 60;
    }else
    {
        [_GainBtn setTitle:[NSString stringWithFormat:@"%lds后重试",(long)self.time] forState:UIControlStateDisabled];
    }
}

-(void)getVerifyFromNet
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:self.txtPhoneNum.text forKey:@"recNum"];
    [net accessNetUrl:URL_SMS parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            self.code = [responseObject objectForKey:@"msg"];
        }else
        {
            Toast *toast = [Toast makeText:@"操作过于频繁,请稍后再试"];
            [toast showWithType:ShortTime];
        }
    }];
}

//判断验证码是否输入正确
-(BOOL)isVerifyTrue
{
    if ([self.txtAuthCode.text isEqualToString:[NSString stringWithFormat:@"%@",self.code]]) {
        return YES;
    }
    Toast *toast = [Toast makeText:@"验证码错误"];
    [toast showWithType:ShortTime];
    return NO;
}

//判断是否是手机号
- (BOOL)validateMobile:(NSString *)mobileNum
{
    if (mobileNum.length == 11)
    {
        return YES;
    }else
    {
        Toast *toast = [Toast makeText:@"请输入正确的手机号码"];
        [toast showWithType:ShortTime];
        
        return NO;
    }
}
-(BOOL)isAllFillOut
{
    if ([self isVerifyTrue] && [self validateMobile:self.txtPhoneNum.text]) {
        return YES;
    }
    return NO;
}

- (IBAction)PutInBtn:(id)sender {
    if ([self isAllFillOut]) {
        [self commitPhoneNumber];
    }
}
-(void)commitPhoneNumber
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:self.txtPhoneNum.text forKey:ACCOUNT];
    [net accessNetUrl:URL parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            Toast *toast = [Toast makeText:@"家政人员注册成功"];
            [toast showWithType:ShortTime];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            Toast *toast = [Toast makeText:responseObject[@"msg"]];
            [toast showWithType:ShortTime];
        }
    }];
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
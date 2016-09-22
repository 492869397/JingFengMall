//
//  ChangeViewController.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
    self.passWord.delegate = self;
    self.passWord2.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirm:(id)sender {
    
    [self changePassword];
}

-(void)changePassword
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:self.account forKey:ACCOUNT];
    [pass setObject:self.passWord.text forKey:@"pwd"];
    [net accessNetUrl:URL_CHANGEPASSWORD parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            [[NSUserDefaults standardUserDefaults]setObject:self.account forKey:ACCOUNT];
            [[NSUserDefaults standardUserDefaults]setObject:self.passWord.text forKey:PASSWORD];
            [self loginUser];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            Toast *toast = [Toast makeText:@"密码修改失败,请重试"];
            [toast showWithType:ShortTime];
        }
    }];
}

-(void)loginUser
{
    NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    NSString *passWord = [[NSUserDefaults standardUserDefaults]objectForKey:PASSWORD];
    if (account && passWord) {
        NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
        [pass setObject:account forKey:ACCOUNT];
        [pass setObject:passWord forKey:PASSWORD];
        Network *net = [[Network alloc]init];
        [net accessNetUrl:URL_LOGIN parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUserLogin"];
            }
        }];
    }
}
@end

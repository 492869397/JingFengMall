//
//  registViewController.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "registViewController.h"
#import "PhotoViewController.h"


@interface registViewController ()

@end

@implementation registViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    UIEdgeInsets edge = UIEdgeInsetsMake(20, 20, 20, 20);
    UIImage *backgroundImage = [[UIImage imageNamed:@"按钮_03"]resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    [self.button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    [self initView];
}

-(void)initView
{
    self.name.delegate = self;
    self.passWord.delegate = self;
    self.passWord2.delegate = self;
    self.boySelect = YES;
    self.sex = @"男";

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
    if ([self isFillDone]) {
        if ([self.passWord.text isEqualToString:self.passWord2.text]) {
            NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
            [pass setObject:self.account forKey:ACCOUNT];
            [pass setObject:self.passWord.text forKey:PASSWORD];
            [pass setObject:self.sex forKey:SEX];
            [pass setObject:self.name.text forKey:@"name"];
            Network *net = [[Network alloc]init];
            [net accessNetUrl:URL_REGISTEINFO parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
                    Toast *toast = [Toast makeText:@"注册成功"];
                    [toast showWithType:ShortTime];
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:ACCOUNT];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PASSWORD];
                    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUserLogin"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }else
        {
            Toast *toast = [Toast makeText:@"两次输入的密码不一致"];
            [toast showWithType:ShortTime];
        }
    }
}

- (IBAction)touchBoy:(id)sender {
    if (!self.boySelect) {
        [self.man setImage:[UIImage imageNamed:@"注册02_03"] forState:UIControlStateNormal];
        self.boySelect = YES;
        [self.woman setImage:[UIImage imageNamed:@"选项_03"] forState:UIControlStateNormal];
        self.sex = @"男";
    }
}

- (IBAction)touchGirl:(id)sender {
    if (self.boySelect) {
        [self.woman setImage:[UIImage imageNamed:@"注册02_03"] forState:UIControlStateNormal];
        self.boySelect = NO;
        [self.man setImage:[UIImage imageNamed:@"选项_03"] forState:UIControlStateNormal];
        self.sex = @"女";
    }
}

//判断内容是否填写完毕
-(BOOL)isFillDone
{
    BOOL a = [self.name.text isEqualToString:@""] ;
    BOOL b = [self.passWord.text isEqualToString:@""];
    BOOL c = [self.passWord2.text isEqualToString:@""];
    if (a || b || c ) {
        Toast *toast = [Toast makeText:@"请填写完整的基本信息"];
        [toast showWithType:ShortTime];
        
        return NO;
    }
    return YES;
}

@end

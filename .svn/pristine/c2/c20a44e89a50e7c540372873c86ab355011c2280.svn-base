//
//  ChangeNameViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ChangeNameViewController.h"

@interface ChangeNameViewController ()

@end

@implementation ChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改昵称";
    
    _name.leftViewMode = UITextFieldViewModeAlways;
    self.name.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    
    _name.clearButtonMode = UITextFieldViewModeAlways;
    
    _name.delegate = self;
    [self.name becomeFirstResponder];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirm:)];
    self.navigationItem.rightBarButtonItem = button;
}

-(void)confirm:(UIButton*)sender
{
    if ([self isNickNameTrue]) {
        Network *net = [[Network alloc]init];
        NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:2];
        NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
        [pass setObject:_name.text forKey:@"nickName"];
        [pass setObject:user forKey:@"userPhone"];
        [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/updateNickName.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
                Toast *toa = [Toast makeText:@"昵称修改成功"];
                [toa showWithType:ShortTime];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                Toast *toa = [Toast makeText:@"修改失败，请检查网络是否畅通"];
                [toa showWithType:ShortTime];
            }
        }];

    }else
    {
        Toast *toa = [Toast makeText:@"昵称不合法"];
        [toa showWithType:ShortTime];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isNickNameTrue
{
    return _name.text.length >= 4 && _name.text.length <=20;
}

@end

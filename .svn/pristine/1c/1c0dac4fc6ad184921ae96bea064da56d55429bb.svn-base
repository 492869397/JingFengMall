//
//  ExamineViewController.m
//  JingFengMall
//
//  Created by len on 16/1/25.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "ExamineViewController.h"
#import "UIImageView+WebCache.h"
#import "Network.h"
#import "PhotoViewController.h"

@interface ExamineViewController ()

@end

@implementation ExamineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是车主";
    self.info.adjustsFontSizeToFitWidth = YES;
    UIEdgeInsets edge = UIEdgeInsetsMake(20, 20, 20, 20);
    UIImage *backgroundImage = [[UIImage imageNamed:@"按钮_03"]resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    [self.button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [self initPhoto];
}

-(void)initPhoto
{
    Network *net = [[Network alloc]init];
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:ACCOUNT];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:name forKey:ACCOUNT];
    [net accessNetUrl:URL_PHOTO parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInteger:-1]] ) {
            //失败
            Toast *toast = [Toast makeText:@"网络连接不稳定"];
            [toast showWithType:ShortTime];
        }else{
            self.info.text = [responseObject objectForKey:@"auditInfo"];
            if (![self.info.text isEqualToString:@"正在审核"]) {
                CGRect frame = self.info.frame;
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(80, frame.origin.y+30 ,kMainScreenWidth-160 ,41 )];
                [button setBackgroundImage:[UIImage imageNamed:@"按钮_03"] forState:UIControlStateNormal];
                [button setTitle:@"重新上传照片" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(enterPhotoView) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
            }
            NSString *urlString = [(NSString*)[responseObject objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlString];
            [self.photo sd_setImageWithURL:url];
        }
    }];
}

-(void)enterPhotoView
{
    PhotoViewController *photo = [[PhotoViewController alloc]init];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:photo animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)confirm:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

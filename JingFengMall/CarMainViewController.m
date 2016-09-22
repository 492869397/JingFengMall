//
//  CarMainViewController.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "LoginViewController.h"
#import "CarMainViewController.h"
#import "GetCarViewController.h"
#import "CarMassageViewController.h"
#import "DiverOrderTableViewController.h"
#import "PhotoViewController.h"
#import "HistoryTableViewController.h"
#import "ExamineViewController.h"
#import "HintView.h"
#import "MBProgressHUD.h"


@interface CarMainViewController ()

@property(strong,nonatomic)MBProgressHUD *HUD;

@end

@implementation CarMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用车出行";
    self.automaticallyAdjustsScrollViewInsets = NO;
}


-(void)viewDidAppear:(BOOL)animated
{
    [self createScrollView];
}



- (void)createScrollView
{

    NSMutableArray *imageNameArray = [[NSMutableArray alloc]init];
    
    CGSize size = self.scroll.frame.size;
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"banner_02" ofType:@"png"];
    image.image = [UIImage imageWithContentsOfFile:path];
    [imageNameArray addObject:image];
    
    path = [[NSBundle mainBundle]pathForResource:@"banner2_02" ofType:@"png"];
    UIImageView *image2 = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:path]];
    image2.frame = CGRectMake(0, 0, size.width, size.height);
    [imageNameArray addObject:image2];
    
    YYCycleScrollView *scrollView = [[YYCycleScrollView alloc]initWithFrame:self.scroll.frame animationDuration:2.0];
    scrollView.totalPagesCount = ^NSInteger{
    
        return imageNameArray.count;
    };
    scrollView.fetchContentViewAtIndex = ^UIView*(NSInteger pageIndex){
        
        return imageNameArray[pageIndex];
    
    };
    
    [self.view addSubview:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//判断当前是否是登陆状态
-(BOOL)isUserLogin
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"];
}

- (IBAction)getCar:(id)sender {
    
    if ([self isUserLogin]) {
        GetCarViewController *getView = [[GetCarViewController alloc]init];
        [self.navigationController pushViewController:getView animated:YES];
    }else
    {
        [self enterLoginView];
    }
}

- (IBAction)carOwner:(id)sender {
    
    if ([self isUserLogin]) {
        
        [self isDiverMassageDone];
        
    }else
    {
        [self enterLoginView];
    }
}

- (IBAction)enterHistory:(id)sender {
    
    if ([self isUserLogin]) {
        HistoryTableViewController *history = [[HistoryTableViewController alloc]init];
        [self.navigationController pushViewController:history animated:YES];
    }else
    {
        [self enterLoginView];
    }
}

//进入登陆页面
-(void)enterLoginView
{
    LoginViewController *loginView = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}

//判断车主信息是否注册
-(void)isDiverMassageDone
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    
    view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    
    [self.view addSubview:view];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.label.text = @"Loading";
    [_HUD showAnimated:YES];

    
    NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:account forKey:ACCOUNT];
    Network *net = [[Network alloc]init];
    [net accessNetUrl:URL_GETSELFCARMASSAGE parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            [self isPersonalComfirmDone];
            
        }else
        {
            CarMassageViewController *photo = [[CarMassageViewController alloc]init];
            [self.navigationController pushViewController:photo animated:YES];
        }
        
        [view removeFromSuperview];
        
    }];
}

//判断实名认证是否完成
-(void)isPersonalComfirmDone
{
    NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:account forKey:ACCOUNT];
    Network *net = [[Network alloc]init];
    [net accessNetUrl:URL_PHOTO parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInteger:-1]]) {
            Toast *toast = [Toast makeText:@"网络错误"];
            [toast showWithType:ShortTime];
        }else if([[responseObject objectForKey:@"photo"]isKindOfClass:[NSNull class]])
        {
            PhotoViewController *photo = [[PhotoViewController alloc]init];
            [self.navigationController pushViewController:photo animated:YES];
        }
        else if ([(NSString*)[responseObject objectForKey:@"auditInfo"] hasPrefix:@"审核通过"])
        {
            DiverOrderTableViewController *view = [[DiverOrderTableViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }else
        {
            ExamineViewController *examine = [[ExamineViewController alloc]init];
            [self.navigationController pushViewController:examine animated:YES];
        }
    }];
}

@end
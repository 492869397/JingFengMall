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
#import "DiverLoginViewController.h"
#import "ExamineViewController.h"

#import "HintView.h"

@interface CarMainViewController ()

@end

@implementation CarMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用车出行";
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self initNavigaton];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self createScrollView];
    [self initNavigaton];
}

-(void)initNavigaton
{
    UIBarButtonItem *rightBarButton;
    if ([self isUserLogin]) {
        rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(loginOut)];
    }else
    {
        rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(enterLoginView)];
    }
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

//
-(void)loginOut
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:NO forKey:@"isUserLogin"];
    [user removeObjectForKey:ACCOUNT];
    [user removeObjectForKey:PASSWORD];
    [self initNavigaton];
}

- (void)createScrollView
{
    //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
//    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    NSMutableArray *imageNameArray = [[NSMutableArray alloc]init];
    [imageNameArray addObject:@"banner_02"];
    [imageNameArray addObject:@"banner_02"];
    [imageNameArray addObject:@"banner2_02"];
    
    self.scrollView = [[AdScrollView alloc]initWithFrame:self.scrollView.frame];
    _scrollView.imageNameArray = imageNameArray;
    _scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    _scrollView.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
//    [_scrollView setAdTitleArray:dataModel.adTitleArray withShowStyle:AdTitleShowStyleLeft];
    
    _scrollView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
}

//判断当前是否是登陆状态
-(BOOL)isUserLogin
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        DiverLoginViewController *login = [[DiverLoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
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
        else if ([[responseObject objectForKey:@"auditInfo"]isEqualToString:@"审核通过"])
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

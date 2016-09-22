//
//  HomeViewcController.m
//  JingFengMall
//
//  Created by len on 16/3/7.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "RDVTabBarController.h"
#import "HomeTestViewController.h"
#import "UIImageView+WebCache.h"

#import "UINavigationBar+Background.h"
#import "HomeViewController.h"

#import "LoginViewController.h"
#import "SerchViewController.h"


@implementation HomeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSubViews];
    
    
    UISearchBar *sear = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    self.navigationItem.titleView = sear;
    sear.delegate = self;
    sear.placeholder = @"请输入要搜索的关键字";
}

-(void)setSubViews
{
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    _scroll.showsVerticalScrollIndicator = NO;
    
    self.scroll.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self reload];
    }];
    
    [self.view addSubview:_scroll];
    
    self.homeView = [[HomeTestViewController alloc]init];
    _homeView.delegate = self;
    
    _homeView.view.translatesAutoresizingMaskIntoConstraints = NO;
    _homeView.width.constant = kMainScreenWidth;
    
    [_scroll addSubview:_homeView.view];
    
    [_scroll addConstraint:[NSLayoutConstraint constraintWithItem:_homeView.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scroll attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [_scroll addConstraint:[NSLayoutConstraint constraintWithItem:_homeView.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_scroll attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [_scroll addConstraint:[NSLayoutConstraint constraintWithItem:_homeView.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_scroll attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [_scroll addConstraint:[NSLayoutConstraint constraintWithItem:_homeView.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_scroll attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    
    [_scroll.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏的背景色是黑色, 字体为白色
    [self scrollViewDidScroll:self.scroll];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
    
    self.scroll.delegate = self;

}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    self.scroll.delegate = nil;
    [self.navigationController.navigationBar cnReset];
    
}



#pragma searchbardelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SerchViewController *vc = [[SerchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    
    return NO;
}


//判断当前是否是登陆状态
-(BOOL)isUserLogin
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"];
}

//进入登陆页面
-(void)enterLoginView
{
    LoginViewController *loginView = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}





- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;

    self.navigationController.navigationBarHidden = NO;
    CGFloat alpha = MIN(1, (offsetY - 20 ) / 250.0);
    [self.navigationController.navigationBar cnSetBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:alpha ]];

}


//刷新数据
-(void)reload
{
    [self.homeView fresh];
    self.freshTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(isFreshComplate) userInfo:nil repeats:YES];
}

-(void)isFreshComplate
{
    if (_homeView.freshComplate) {
        _homeView.freshComplate = NO;
        [self.scroll.mj_header endRefreshing];
        [self.freshTimer invalidate];
    }
}

@end
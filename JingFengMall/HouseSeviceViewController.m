//
//  HouseSeviceViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HouseSeviceViewController.h"
#import "HomeFuwuViewController.h"
#import "HomeSecondViewController.h"
#import "HomeOrderViewController.h"
#import "HomeServiceCollectionViewCell.h"
#import "SubscribeViewController.h"
#import "HomeSeviceView.h"

@interface HouseSeviceViewController()<UIScrollViewDelegate>

@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)UIButton *btn;

@end

@implementation HouseSeviceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionView *collection = [self.view viewWithTag:10];
    [collection registerClass:[HomeServiceCollectionViewCell class] forCellWithReuseIdentifier:@"HomeServiceCollectionViewCell"];

    self.title = @"选择服务";
 
    
    UIButton *rightBar = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBar setImage:[UIImage imageNamed:@"订单详情按钮.png"] forState:UIControlStateNormal];
    [rightBar addTarget:self action:@selector(btnClickOrder) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBar];
    
    
    self.navigationItem.rightBarButtonItem = temporaryBarButtonItem;

    HomeSeviceView *HouseSeviceView = [[[NSBundle mainBundle]loadNibNamed:@"HomeSeviceView" owner:nil options:nil]firstObject];
    
    HouseSeviceView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 794);
    
    HouseSeviceView.width.constant = (SCREEN_WIDTH - 5 * 20)/4.0;
    HouseSeviceView.height.constant = HouseSeviceView.width.constant;
    
    [self.scrollView addSubview:HouseSeviceView];
    [self.view addSubview:self.scrollView];


    
}

//- (HouseSeviceView *)HouseSeviceView {
//    
//    if (!_HouseSeviceView) {
//        _HouseSeviceView = [[[NSBundle mainBundle]loadNibNamed:@"HouseSeviceView" owner:nil options:nil] firstObject];
//    }
//    return _HouseSeviceView;
//}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 794);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = FALSE;
        _scrollView.showsHorizontalScrollIndicator = true;
        _scrollView.scrollEnabled = YES;
        [_scrollView flashScrollIndicators];
        _scrollView.directionalLockEnabled = YES;

    }
    return _scrollView;
}
- (void)btnClickOrder{
    NSLog(@"sdc");
    HomeOrderViewController *HOVC = [[HomeOrderViewController alloc]init];
    [self.navigationController pushViewController:HOVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeServiceCollectionViewCell" forIndexPath:indexPath];
    
    UIImageView *pic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-50)];
    [cell addSubview:pic];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 40)];
    
    title.text = @"你的家政";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:20];
    title.center = CGPointMake(pic.center.x, pic.frame.origin.y+pic.frame.size.height + 20);
//    [title sizeToFit];
    
    [cell addSubview:title];
    
    
    cell.pic.image = [UIImage imageNamed:@"jiaoche1-03"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubscribeViewController *subscribe = [[SubscribeViewController alloc]init];
    
    [self.navigationController pushViewController:subscribe animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kMainScreenWidth-2)/3.0, (kMainScreenHeight-44-2)/3.0);
}


@end
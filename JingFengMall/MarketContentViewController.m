//
//  MarketContentViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "MarketContentViewController.h"
#import "YGImageView.h"
#import "MarketViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "GoodsDetailViewController.h"
#import "RDVTabBarController.h"

@interface MarketContentViewController ()

@end

@implementation MarketContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size1 = _scroll1.frame.size;
    self.adscroll1 = [[YYCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, size1.width, size1.height) animationDuration:2.0];
    [_scroll1 addSubview:_adscroll1];
    
    CGSize size2 = _scroll2.frame.size;
    self.adscroll2 = [[YYCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, size2.width, size2.height) animationDuration:2.0];
    [_scroll2 addSubview:_adscroll2];
    
    CGSize size3 = _scroll3.frame.size;
    self.adscroll3 = [[YYCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, size3.width, size3.height) animationDuration:2.0];
    [_scroll3 addSubview:_adscroll3];
    
}

-(void)fresh
{
    NSString *urlString = [@"http://123.57.28.11:8080/jfsc_app/chartMall.do" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFHTTPSessionManager manager] POST:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
            
            
            NSArray *arr = [NSArray arrayWithArray:[responseObject objectForKey:@"list"]];
            
            
            
            NSString* urlString = [(NSString*)[arr[0] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlString];
            
            YGImageView *image = [[YGImageView alloc]initWithFrame:_scroll.frame];
            [image sd_setImageWithURL:url];
            
            [self.scroll addSubview:image];
            
            [self setPic:arr];
            
            self.freshComplate = YES;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        [((MarketViewController*)(self.delegate)).scroll.mj_header endRefreshing];
        Toast *toa = [Toast makeText:@"网络连接失败,请重试"];
        [toa showWithType:ShortTime];
        
    }];
    
}

-(void)setPic:(NSArray*)arr
{
    
    int i;
    
#pragma 设置普通图片

    for ( i = 1; i < 27; i++) {
        
        NSString* urlString = [(NSString*)[arr[i] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        
        UIButton *button = [self.view viewWithTag:(6+i)];
        
        YGImageView *image = [[YGImageView alloc]initWithFrame:button.bounds];
        image.module = [arr[i] objectForKey:@"module"];
        image.type = [arr[i] objectForKey:@"typeID"];
        image.tag = button.tag;
        [image addTapEvent:^(YGImageView *image) {
            [self tapImage:(image)];
        }];
        
        [image sd_setImageWithURL:url];
        
        
        if ([[[button subviews]lastObject] isKindOfClass:[UIImageView class]]) {
            [[[button subviews]lastObject]removeFromSuperview];
        }
        
        
        [button addSubview:image];
        
    }
    
#pragma 设置轮播图
    NSMutableArray *imageArray1 = [[NSMutableArray alloc]init];
    NSMutableArray *imageArray2 = [[NSMutableArray alloc]init];
    NSMutableArray *imageArray3 = [[NSMutableArray alloc]init];

    for ( ; i < arr.count ; i++) {
        
        NSString *str = [arr[i] objectForKey:@"typeID"];
        NSString* urlString = [(NSString*)[arr[i] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        
        YGImageView *image = [[YGImageView alloc]init];
        image.module = [arr[i] objectForKey:@"module"];
        image.type = [arr[i] objectForKey:@"typeID"];
        [image addTapEvent:^(YGImageView *image) {
            [self tapImage:(image)];
        }];
        [image sd_setImageWithURL:url];
        
        
        if ([str isEqualToString:@"a"]) {
            
            image.frame = _adscroll1.frame;
            [imageArray1 addObject:image];

        }else if ([str isEqualToString:@"b"])
        {
            image.frame = _adscroll1.frame;
            [imageArray2 addObject:image];
            
        }else if ([str isEqualToString:@"c"])
        {
            image.frame = _adscroll1.frame;
            [imageArray3 addObject:image];
        }
    }
    
    [_adscroll1 setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
        
        return [imageArray1 objectAtIndex:pageIndex];
        
    }];
    
    [_adscroll1 setTotalPagesCount:^NSInteger{
        
        return imageArray1.count;
        
    }];
    [_adscroll2 setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
        
        return [imageArray2 objectAtIndex:pageIndex];
        
    }];
    
    [_adscroll2 setTotalPagesCount:^NSInteger{
        
        return imageArray2.count;
        
    }];
    [_adscroll3 setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
        
        return [imageArray3 objectAtIndex:pageIndex];
        
    }];
    
    [_adscroll3 setTotalPagesCount:^NSInteger{
        
        return imageArray3.count;
        
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)tapImage:(YGImageView*)imageview
{
    GoodsDetailViewController *detail = [[GoodsDetailViewController alloc]init];
    detail.goodsID = [NSNumber numberWithInteger: imageview.type.integerValue];
    [((MarketViewController*)self.delegate).rdv_tabBarController.navigationController pushViewController:detail animated:YES];
}



@end
//
//  HomeTestViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeTestViewController.h"
#import "CarMainViewController.h"
#import "HouseSeviceViewController.h"
#import "HomeViewController.h"
#import "SerchViewController.h"
#import "FoodViewController.h"

#import "RDVTabBarController/RDVTabBarController.h"

#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "YGImageView.h"
#import "GoodsModel.h"

@interface HomeTestViewController ()

@end

@implementation HomeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buttonHeight.constant = kMainScreenWidth*1.25/6;
    _mallBigWith.constant = kMainScreenWidth/2.2;
    _mallBigHeight.constant = _mallBigWith.constant * 310/295;
    _mallSmallHeight.constant = kMainScreenWidth/4 *315/270;
    _storeBigWith.constant = kMainScreenWidth/2.2;
    _storeBigHeight.constant = _storeBigWith.constant *620/490;
    _foodHeight.constant = kMainScreenWidth/4 *310/295;
    
}

-(void)fresh
{
    [self setPic];
}

-(void)setPic
{
    NSString *urlString = [URL_HOMEPIC stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[AFHTTPSessionManager manager] POST:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
            
            
            [self setMallPic:[NSArray arrayWithArray:[responseObject objectForKey:@"listCommodity"]]];
            
            [self setEnterStorePic:[NSArray arrayWithArray:[responseObject objectForKey:@"listCatering"]]];
            
            [self setFoodOutPic:[NSArray arrayWithArray:[responseObject objectForKey:@"listTakeaway"]]];
            
            
            NSArray *arr = [NSArray arrayWithArray:[responseObject objectForKey:@"listModule"]];
            
//            NSMutableArray *urlArray = [[NSMutableArray alloc]init];
//            NSMutableArray *nameArray = [[NSMutableArray alloc]init];
//            
//            for (int i = 0; i < 6; i++) {
//                
//                NSString* urlString = [(NSString*)[arr[i] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                NSURL *url = [NSURL URLWithString:urlString];
//                [urlArray addObject:url];
//                
//                NSString *name = (NSString*)[arr[i] objectForKey:@"name"];
//                [nameArray addObject:name];
//            }
//            
//            for (int i = 0; i <6; i++) {
//                UIButton *button = [self.view viewWithTag:(i+1)];
//                [button setImageForState:UIControlStateNormal withURL:urlArray[i]];
//                [button setTitle:nameArray[i]  forState:UIControlStateNormal];
//            }
            
            
            NSString* urlString = [(NSString*)[arr[6] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlString];
            
            YGImageView *image = [[YGImageView alloc]initWithFrame:_scroll.frame];
            [image sd_setImageWithURL:url];
            
            [self.scroll addSubview:image];
            
            self.freshComplate = YES;
        }

        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        [((HomeViewController*)(self.delegate)).scroll.mj_header endRefreshing];
        Toast *toa = [Toast makeText:@"网络连接失败,请重试"];
        [toa showWithType:ShortTime];
        
    }];

}

-(void)setMallPic:(NSArray *)array
{
    
    for (int i = 0; i< 12; i++) {
        
        NSString* urlString = [(NSString*)[array[i] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];

        UIButton *button = [self.view viewWithTag:(7+i)];
        
        YGImageView *image = [[YGImageView alloc]initWithFrame:button.bounds];
        image.module = [array[i] objectForKey:@"module"];
        image.type = [array[i] objectForKey:@"typeID"];
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
    
    CGSize size = _scroll1.frame.size;
    self.adscroll1 = [[YYCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height) animationDuration:2.0];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (int i = 12 ; i < array.count ; i++) {
        NSString* urlString = [(NSString*)[array[i] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
       
        
        YGImageView *image = [[YGImageView alloc]initWithFrame:_adscroll1.frame];
        image.module = [array[i] objectForKey:@"module"];
        image.type = [array[i] objectForKey:@"typeID"];
        
        [image addTapEvent:^(YGImageView *image) {
            [self tapImage:(image)];
        }];
        [image sd_setImageWithURL:url];
        [imageArray addObject:image];
    }
    
    [_adscroll1 setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
        
        return [imageArray objectAtIndex:pageIndex];
        
    }];
    
    [_adscroll1 setTotalPagesCount:^NSInteger{
        
        return imageArray.count;
        
    }];
    
    [_adscroll1 setTapActionBlock:^(NSInteger(pageIndex)) {
        
        
    }];
    
    [self.scroll1 addSubview:_adscroll1];
    

}

-(void)setEnterStorePic:(NSArray *)array
{
    
    for (int i = 0; i < 4; i++) {
        
        NSString *urlString = [(NSString*)[array[i] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        
        UIButton *button = [self.view viewWithTag:(19+i)];
        button.contentMode = UIViewContentModeScaleAspectFit;
        [button sd_setImageWithURL:url forState:UIControlStateNormal];

        
    }
    
    
    CGSize size = _scroll2.frame.size;
    self.adscroll2 = [[YYCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height) animationDuration:2.0];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (int i = 4 ; i < array.count ; i++) {
        NSString* urlString = [(NSString*)[array[i] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        
        CGSize size = _adscroll2.frame.size;
        YGImageView *image = [[YGImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        
        image.module = [array[i] objectForKey:@"module"];
        image.type = [array[i] objectForKey:@"typeID"];
        
        [image addTapEvent:^(YGImageView *image) {
            [self tapImage:(image)];
        }];
        
        [image sd_setImageWithURL:url];
        [imageArray addObject:image];
    }
    
    [_adscroll2 setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
        
        return [imageArray objectAtIndex:pageIndex];
        
    }];
    
    [_adscroll2 setTotalPagesCount:^NSInteger{
        
        return imageArray.count;
        
    }];
    
    [_adscroll2 setTapActionBlock:^(NSInteger(pageIndex)) {
        
        
    }];
    
    [self.scroll2 addSubview:_adscroll2];
    
}

-(void)setFoodOutPic:(NSArray*)array
{
    
    for (int i = 0; i< array.count && i< 8; i++) {
        NSString* urlString = [(NSString*)[array[i] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        
        UIButton *button = [self.view viewWithTag:(23+i)];
        button.contentMode = UIViewContentModeScaleAspectFit;
        [button sd_setImageWithURL:url forState:UIControlStateNormal];

        
    }
    
    CGSize size = _scroll3.frame.size;
    self.adscroll3 = [[YYCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height) animationDuration:2.0];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (int i = 8 ; i < array.count ; i++) {
        NSString* urlString = [(NSString*)[array[i] objectForKey:@"photo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        

        YGImageView *image = [[YGImageView alloc]initWithFrame:_adscroll3.frame];
        
        image.module = [array[i] objectForKey:@"module"];
        image.type = [array[i] objectForKey:@"typeID"];
        
        [image addTapEvent:^(YGImageView *image) {
            [self tapImage:(image)];
        }];

        [image sd_setImageWithURL:url];
        [imageArray addObject:image];
    }
    
    [_adscroll3 setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
        
        return [imageArray objectAtIndex:pageIndex];
        
    }];
    
    [_adscroll3 setTotalPagesCount:^NSInteger{
        
        return imageArray.count;
        
    }];

    
    [self.scroll3 addSubview:_adscroll3];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)selectByTag:(UIButton*)sender {
    
    UIViewController *vc;
    
    switch (sender.tag) {
        case 1:
            
            break;
        
        case 2:
            
            break;
            
        case 3:
            
            if (![[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"]) {
                
                Toast *toa = [Toast makeText:@"登录后才能查看此页面"];
                [toa showWithType:ShortTime];
                
                LoginViewController *login = [[LoginViewController alloc]init];
                [self.delegate.navigationController pushViewController:login animated:YES];
                
                return;
                
            }
            
            vc = [[FoodViewController alloc]init];

            break;
            
        case 4:
            vc = [[CarMainViewController alloc]init];
            break;
            
        case 5:
            
            break;
            
        default:
            if (![[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"]) {
                
                Toast *toa = [Toast makeText:@"登录后才能查看此页面"];
                [toa showWithType:ShortTime];
        
                LoginViewController *login = [[LoginViewController alloc]init];
                [self.delegate.navigationController pushViewController:login animated:YES];
                
                return;
                
            }

            vc = [[HouseSeviceViewController alloc]init];
            break;
    }
    
    if (vc) {
        [((HomeViewController*)self.delegate).rdv_tabBarController.navigationController pushViewController:vc animated:YES];
    }
    
    
//    if (sender.tag <= 6) {
//        CarMainViewController *car = [[CarMainViewController alloc]init];
//        [((HomeViewController*)self.delegate).rdv_tabBarController.navigationController pushViewController:car animated:YES];
//    }
   
}

-(void)tapImage:(YGImageView*)image
{
    SerchViewController *vc = [[SerchViewController alloc]init];
    
    vc.isSearchBarNOActivity = YES;
    
    [((HomeViewController*)self.delegate).rdv_tabBarController.navigationController pushViewController:vc animated:YES];
    
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:image.type forKey:@"typeID"];
    [pass setObject:image.module forKey:@"module"];

    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/selectMallCommodity.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            NSArray *arr = [responseObject objectForKey:@"list"];
            NSMutableArray *array = [NSMutableArray array];
            [array removeAllObjects];
            for (NSDictionary *dic in arr) {
                GoodsModel *good = [[GoodsModel alloc]initWhthID:[dic objectForKey:@"id"] Title:[dic objectForKey:@"name"] describe:[dic objectForKey:@"describe"] photo:[dic objectForKey:@"photo"] price:[dic objectForKey:@"retailPrice"] originalPrice:[dic objectForKey:@"originalPrice"] buyCount:[dic objectForKey:@"buyCount"] discount:[dic objectForKey:@"discount"] praiseCount:[dic objectForKey:@"praiseCount"] upFrame:[dic objectForKey:@"upFrame"] createTime:[dic objectForKey:@"createTime"]];
                [array addObject:good];
            }

            vc.array = array;
            [vc.tableVeiw reloadData];
        }
        
    }];
}

@end
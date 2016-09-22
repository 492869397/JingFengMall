//
//  MarketViewController.h
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "MJRefresh/MJRefresh.h"
#import "MarketContentViewController.h"
#import "BaseRootViewController.h"

@interface MarketViewController : BaseRootViewController<UIScrollViewDelegate,UISearchBarDelegate>

@property(strong,nonatomic)UIScrollView *scroll;

@property(strong,nonatomic)MarketContentViewController *market;

@property(strong,nonatomic)NSTimer *freshTimer;

@end

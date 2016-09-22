//
//  MarketContentViewController.h
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "YYCycleScrollView.h"

@interface MarketContentViewController : UIViewController

@property(weak,nonatomic)id delegate;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *width;

@property (strong, nonatomic) IBOutlet UIView *scroll;
@property (strong, nonatomic) IBOutlet UIView *scroll1;
@property (strong, nonatomic) IBOutlet UIView *scroll2;
@property (strong, nonatomic) IBOutlet UIView *scroll3;

@property (strong, nonatomic) YYCycleScrollView *adscroll1;
@property (strong, nonatomic) YYCycleScrollView *adscroll2;
@property (strong, nonatomic) YYCycleScrollView *adscroll3;

@property(assign,nonatomic)BOOL freshComplate;

-(void)fresh;

@end

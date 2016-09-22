//
//  JingFengMoneyViewController.h
//  JingFengMall
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JingFengMoneyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(assign,nonatomic)id delegate;


//全部数据
@property(strong,nonatomic)NSMutableArray *array;

@property(strong,nonatomic)NSNumber *JingFengCoin;

-(void)fresh;


@end

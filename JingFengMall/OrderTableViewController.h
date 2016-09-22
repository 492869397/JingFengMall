//
//  OrderTableViewController.h
//  JingFengMall
//
//  Created by len on 16/2/15.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//


@interface OrderTableViewController : UITableViewController

@property(strong,nonatomic)NSMutableArray *orderArray;
@property(strong,nonatomic)NSTimer *timer;

-(void)getordersInfo;

@end

//
//  HistoryTableViewController.h
//  JingFengMall
//
//  Created by len on 16/2/17.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "OrderModel.h"

@interface HistoryTableViewController : UITableViewController

@property(strong,nonatomic)NSMutableArray *orderArray;
@property(strong,nonatomic)NSMutableArray *diverArray;
@property(strong,nonatomic)NSMutableArray *passengerArray;
@property(assign,nonatomic)BOOL isDidsplayDiver;

@end

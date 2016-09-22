//
//  CartTableViewController.h
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "BaseRootViewController.h"

@interface CartTableViewController : BaseRootViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSMutableArray *arr;//存储商品数量信息

@property(strong,nonatomic)NSMutableArray *array;//总数据

@property(strong,nonatomic)NSMutableArray *selectArray;//已经选中的cell

@property(strong,nonatomic)NSMutableArray *mark;//每个cell是否选中的标记

@property (strong, nonatomic) IBOutlet UITableView *tableview;


- (IBAction)selectAll:(id)sender;
- (IBAction)deleteGoods:(id)sender;
- (IBAction)commitOrder:(id)sender;


-(void)deselectedCellButtonWith:(UITableViewCell*)cell checked:(BOOL)flag;

@end

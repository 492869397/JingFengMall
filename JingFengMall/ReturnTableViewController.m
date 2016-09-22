//
//  ReturnTableViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ReturnTableViewController.h"
#import "ReturnTableViewCell.h"
#import "GoodsModel.h"

@interface ReturnTableViewController ()

@end

@implementation ReturnTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退换货";
        
    self.tableView.rowHeight = 243;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.array = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"];
    [pass setObject:name forKey:@"userPhone"];
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/selectMallOrderForReturn.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [_array removeAllObjects];
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            NSArray *arr = [responseObject objectForKey:@"list"];
            int index = 0;
            for (NSDictionary *dic in arr) {
                MallOrderModel *order = [[MallOrderModel alloc]initWithCommodityid:[dic objectForKey:@"id"] commodityNumber:[dic objectForKey:@"commodityIDNumber"] paymentState:[dic objectForKey:@"paymentState"] paymentMethod:[dic objectForKey:@"paymentMethod"] userName:[dic objectForKey:@"userName"] orderMoney:[dic objectForKey:@"orderMoney"] completeState:[dic objectForKey:@"completeState"] consignorPhone:[dic objectForKey:@"consignorPhone"] userAddressID:[dic objectForKey:@"userAddressID"]];
                
                NSString *num = order.commodityNumber;
                NSArray *a = [num componentsSeparatedByString:@","];
                for (int i = 0; i <= a.count - 2; i+=2) {
                    NSString *s = [NSString stringWithFormat:@"commodity%d%d",index,i];
                    NSDictionary *dic = [[responseObject objectForKey:s]firstObject];
                    GoodsModel *good = [[GoodsModel alloc]initWhthID:[dic objectForKey:@"id"] Title:[dic objectForKey:@"name"] describe:[dic objectForKey:@"describe"] photo:[dic objectForKey:@"photo"] price:[dic objectForKey:@"retailPrice"] originalPrice:[dic objectForKey:@"originalPrice"] buyCount:[dic objectForKey:@"buyCount"] discount:[dic objectForKey:@"discount"] praiseCount:[dic objectForKey:@"praiseCount"] upFrame:[dic objectForKey:@"upFrame"] createTime:[dic objectForKey:@"createTime"]];
                    [order.goodsArray addObject:good];
                    
                }
                index ++;
                
                [_array addObject:order];
            }
        }else
        {
            Toast *toa = [Toast makeText:@"暂时没有可退换货的订单"];
            [toa showWithType:ShortTime];
        }
        
        [self.tableView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReturnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"return"];
    
    if ( cell == nil ) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ReturnTableViewCell" owner:nil options:nil]firstObject];
    }
    
    cell.bounds = CGRectMake(0, 0, kMainScreenWidth, tableView.rowHeight);
    
    cell.order = _array[indexPath.row];
    cell.delegate = self;
    
    
    return cell;
}


@end

//
//  MyOrderViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MallOrderModel.h"
#import "UngetTableViewCell.h"
#import "UnsendTableViewCell.h"
#import "UncommentTableViewCell.h"
#import "UnpaymentTableViewCell.h"
#import "ReturnTableViewCell.h"
#import "GoodsModel.h"

@interface MyOrderViewController ()

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    
    self.array = [[NSMutableArray alloc]init];
    
//    self.tableview.rowHeight = 243;
    self.tableview.estimatedRowHeight = 243;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    NSUInteger index = [_OrderTypeArr indexOfObject:_mallOrderType];
    
    self.selectLine = [[UIView alloc]initWithFrame:CGRectMake(((kMainScreenWidth-4)/5.0+1)*index, 41, (kMainScreenWidth-4)/5.0, 3)];
    
    _selectLine.backgroundColor = [UIColor redColor];
    
    [[self.view viewWithTag:100] addSubview:_selectLine];
    
    [self getData];
    
}

-(void)getData
{
    
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:phoneNumber forKey:@"userPhone"];
    [pass setObject:_mallOrderType forKey:@"str"];
    
    [net accessNetUrl:URL_MALLORDER parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
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
        }
        else if([[responseObject objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInteger:-1]])
        {
            Toast *toa = [Toast makeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]]];
            [toa showWithType:ShortTime];
        }
        
        [self.tableview reloadData];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableView DataSouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

#pragma tableView delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallOrderModel *order = _array[indexPath.row];
    
    if ([order.paymentState isEqualToString:@"待付款"])
    {
        UnpaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"unpay"];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"UnpaymentTableViewCell" owner:nil options:nil]firstObject];
            
        }
//        cell.bounds = CGRectMake(0, 0, kMainScreenWidth, _tableview.rowHeight);
        cell.delegate = self;
        
        cell.order = order;
        
        return cell;
        
    }
    else if ([order.paymentState isEqualToString:@"待发货"])
    {
        UnsendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"unsend"];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"UnsendTableViewCell" owner:nil options:nil]firstObject];
            
        }
//        cell.bounds = CGRectMake(0, 0, kMainScreenWidth, _tableview.rowHeight);
        cell.delegate = self;
        
        cell.order = order;
        
        return cell;
        
    }
    
    else if ([order.paymentState isEqualToString:@"待收货"])
    {
        UngetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"unget"];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"UngetTableViewCell" owner:nil options:nil]firstObject];
        }
//        cell.bounds = CGRectMake(0, 0, kMainScreenWidth, _tableview.rowHeight);
        cell.delegate = self;
        
        cell.order = order;
        
        return cell;
        
    }
    
    else
    {
        UncommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uncomment"];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"UncommentTableViewCell" owner:nil options:nil]firstObject];
        }
        
//        cell.bounds = CGRectMake(0, 0, kMainScreenWidth, _tableview.rowHeight);
        
        cell.delegate = self;
        
        cell.order = order;
        
        return cell;
        
    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (IBAction)displayOrderByTag:(UIButton*)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        _selectLine.center = CGPointMake(sender.center.x, _selectLine.center.y);
    }];
    
    self.mallOrderType = _OrderTypeArr[sender.tag-1];
    
    [self getData];
    
}

@end

//
//  OrderTableViewController.m
//  JingFengMall
//
//  Created by len on 16/2/15.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "OrderTableViewController.h"
#import "OrderModel.h"
#import "OrderStatusViewController.h"

@interface OrderTableViewController ()

@end

@implementation OrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单状态";
    
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    self.tableView.rowHeight = 120;
    
    self.orderArray = [[NSMutableArray alloc]init];
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getordersInfo];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(getordersInfo) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.timer invalidate];
}

-(void)getordersInfo
{
    Network *net = [[Network alloc]init];
    NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:account forKey:@"orderUserPhone"];
    [net accessNetUrl:URL_SELFORDER parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            NSArray *array = [responseObject objectForKey:@"list"];
            [self.orderArray removeAllObjects];
            for (NSDictionary* dic in array) {
                //判断完成时间是否为null,是的话要进行一些操作
                NSString *recivedPhone = [[dic objectForKey:@"receiveUserPhone"] isKindOfClass:[NSNull class]]?@"0":[dic objectForKey:@"receiveUserPhone"];
                NSDate *createTime = [NSDate dateWithTimeIntervalSince1970:((NSNumber*)[dic objectForKey:@"createTime"]).doubleValue/1000 ];
                NSDate *completeTime = [[dic objectForKey:@"completeTime"] isKindOfClass:[NSNull class]]?[NSDate date]:[NSDate dateWithTimeIntervalSince1970:((NSNumber*)[dic objectForKey:@"completeTime"]).doubleValue/1000];
                OrderModel *order = [[OrderModel alloc]initWithStartPosition:[dic objectForKey:@"startPosition"] endPosition:[dic objectForKey:@"endPosition"] orderUserPhone:[dic objectForKey:@"orderUserPhone"] receiveUserPhone:recivedPhone createTime:createTime completeState:[dic objectForKey:@"completeState"] completeTime:completeTime orderId:((NSNumber*)[dic objectForKey:@"id"]).integerValue startLat:[dic objectForKey:@"startLat"] startLng:[dic objectForKey:@"startLng"] endLat:[dic objectForKey:@"endLat"] endLng:[dic objectForKey:@"endLng"]];
                [self.orderArray addObject:order];
            }
            [self.orderArray sortUsingComparator:^NSComparisonResult(OrderModel* obj1, OrderModel* obj2) {
                NSInteger a = obj1.orderId;
                NSInteger b = obj2.orderId;
                if (a < b) {
                    return NSOrderedDescending;
                } else if (a > b) {
                    return NSOrderedAscending;
                } else {
                    return NSOrderedSame;
                }
            }];
            [self.tableView reloadData];
        }
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
    return self.orderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderStatusViewController *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderStatusViewController" owner:nil options:nil]firstObject];
    }
    cell.delegate = self;
    cell.order = self.orderArray[indexPath.row];
    [cell setContent];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

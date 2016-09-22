//
//  DiverGotOrderTableViewController.m
//  JingFengMall
//
//  Created by len on 16/2/16.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "DiverGotOrderTableViewController.h"
#import "OnlyOrderViewController.h"

@interface DiverGotOrderTableViewController ()

@end

@implementation DiverGotOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已抢订单";
    
    self.tableView.rowHeight = 120;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(getordersInfo) userInfo:nil repeats:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
//    [self.timer invalidate];
}

//-(void)getordersInfo
//{
//    Network *net = [[Network alloc]init];
//    [net accessNetUrl:URL_ORDER parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
//            NSArray *array = [responseObject objectForKey:@"list"];
//            [self.orderArray removeAllObjects];
//            for (NSDictionary* dic in array) {
//                //判断完成时间是否为null,是的话要进行一些操作
//                NSString *recivedPhone = [[dic objectForKey:@"receiveUserPhone"] isKindOfClass:[NSNull class]]?@"0":[dic objectForKey:@"receiveUserPhone"];
//                NSDate *createTime = [NSDate dateWithTimeIntervalSince1970:((NSNumber*)[dic objectForKey:@"createTime"]).doubleValue/1000 ];
//                NSDate *completeTime = [[dic objectForKey:@"completeTime"] isKindOfClass:[NSNull class]]?[NSDate date]:[NSDate dateWithTimeIntervalSince1970:((NSNumber*)[dic objectForKey:@"completeTime"]).doubleValue/1000];
//                OrderModel *order = [[OrderModel alloc]initWithStartPosition:[dic objectForKey:@"startPosition"] endPosition:[dic objectForKey:@"endPosition"] orderUserPhone:[dic objectForKey:@"orderUserPhone"] receiveUserPhone:recivedPhone createTime:createTime completeState:[dic objectForKey:@"completeState"] completeTime:completeTime orderId:((NSNumber*)[dic objectForKey:@"id"]).integerValue startLat:[dic objectForKey:@"startLat"] startLng:[dic objectForKey:@"startLng"] endLat:[dic objectForKey:@"endLat"] endLng:[dic objectForKey:@"endLng"]];
//                [self.orderArray addObject:order];
//            }
//            [self.tableView reloadData];
//        }
//    }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OnlyOrderViewController *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OnlyOrderViewController" owner:nil options:nil]firstObject];
    }
    [cell.getOrder removeFromSuperview];
    cell.order = self.order;
    cell.delegate = self;
    [cell setContent];
    
    return cell;
}


@end

//
//  HistoryTableViewController.m
//  JingFengMall
//
//  Created by len on 16/2/17.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "HistoryTableViewCell.h"

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史记录";
    
    self.tableView.rowHeight = 150;
    self.orderArray = [[NSMutableArray alloc]init];
    self.passengerArray = [[NSMutableArray alloc]init];
    self.diverArray = [[NSMutableArray alloc]init];
    self.isDidsplayDiver = YES;
    [self getDataFormNet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDataFormNet
{
    Network *net = [[Network alloc]init];
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:phone forKey:ACCOUNT];
    [net accessNetUrl:URL_ORDERHISTORY parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [responseObject objectForKey:@"list"];
        [self.orderArray removeAllObjects];
        for (NSDictionary* dic in array) {
            //判断完成时间是否为null,是的话要进行一些操作
            NSString *recivedPhone = [[dic objectForKey:@"receiveUserPhone"] isKindOfClass:[NSNull class]]?@"0":[dic objectForKey:@"receiveUserPhone"];
            NSDate *createTime = [NSDate dateWithTimeIntervalSince1970:((NSNumber*)[dic objectForKey:@"createTime"]).doubleValue/1000 ];
            NSDate *completeTime = [[dic objectForKey:@"completeTime"] isKindOfClass:[NSNull class]]?[NSDate date]:[NSDate dateWithTimeIntervalSince1970:((NSNumber*)[dic objectForKey:@"completeTime"]).doubleValue/1000];
            OrderModel *order = [[OrderModel alloc]initWithStartPosition:[dic objectForKey:@"startPosition"] endPosition:[dic objectForKey:@"endPosition"] orderUserPhone:[dic objectForKey:@"orderUserPhone"] receiveUserPhone:recivedPhone createTime:createTime completeState:[dic objectForKey:@"completeState"] completeTime:completeTime orderId:((NSNumber*)[dic objectForKey:@"id"]).integerValue startLat:[dic objectForKey:@"startLat"] startLng:[dic objectForKey:@"startLng"] endLat:[dic objectForKey:@"endLat"] endLng:[dic objectForKey:@"endLng"]];
            [self.orderArray addObject:order];
            if ([[dic objectForKey:@"orderUserPhone"]isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT]]) {
                [self.passengerArray addObject:order];
            }else
            {
                [self.diverArray addObject:order];
            }
        }
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isDidsplayDiver) {
        return self.diverArray.count;
    }
    return self.passengerArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HistoryTableViewCell" owner:nil options:nil]firstObject];
    }
    if (self.isDidsplayDiver) {
        OrderModel *order = self.diverArray[indexPath.row];
        cell.startPT.text = order.startPosition;
        cell.endPT.text = order.endPosition;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日 hh:mm:ss"];
        NSString *time = [formatter stringFromDate:order.completeTime];
        cell.time.text = time;
    }else
    {
        OrderModel *order = self.passengerArray[indexPath.row];
        cell.startPT.text = order.startPosition;
        cell.endPT.text = order.endPosition;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日 hh:mm:ss"];
        NSString *time = [formatter stringFromDate:order.completeTime];
        cell.time.text = time;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *diver = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, (kMainScreenWidth-70)/2.0, 40)];
    [diver setBackgroundImage:[UIImage imageNamed:@"按钮_03"] forState:UIControlStateNormal];
    [diver setTitle:@"车主" forState:UIControlStateNormal];
    [diver setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [diver addTarget:self action:@selector(displayDiverTable) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:diver];
    
    UIButton *passenger = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth/2.0+10, 10, (kMainScreenWidth-70)/2.0, 40)];
    [passenger setBackgroundImage:[UIImage imageNamed:@"按钮_03"] forState:UIControlStateNormal];
    [passenger setTitle:@"乘客" forState:UIControlStateNormal];
    [passenger setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [passenger addTarget:self action:@selector(displayPassengerTable) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:passenger];
    
    if (self.isDidsplayDiver) {
        diver.enabled = NO;
    }else
    {
        passenger.enabled = NO;
    }
    
    return view;
}

-(void)displayDiverTable
{
    self.isDidsplayDiver = YES;
    [self.tableView reloadData];
}

-(void)displayPassengerTable
{
    self.isDidsplayDiver = NO;
    [self.tableView reloadData];
}

@end

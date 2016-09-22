//
//  AddressTableViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ConsigneeModel.h"

#import "AddressTableViewController.h"
#import "AddressTableViewCell.h"
#import "AddReciverViewController.h"
#import "RDVTabBarController.h"

@interface AddressTableViewController ()

@end

@implementation AddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地址管理";
    
    self.tableView.rowHeight = 135;
    self.tableView.allowsSelection = NO;
    
    self.array = [[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, kMainScreenWidth, 50)];
    _buttonView.alpha = 0.0;
    _buttonView.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(70, 5 , kMainScreenWidth-140, 40)];
    [button setTitle:@"新建收货人" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(addReciver:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:button];
    [[UIApplication sharedApplication].keyWindow addSubview:_buttonView];
    
    [UIView animateWithDuration:1.0 animations:^{
        _buttonView.alpha = 1.0;
    }];
    
    [self getDataFromNet];
}

-(void)getDataFromNet
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:2];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/selectAddress.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [_array removeAllObjects];
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            NSArray *arr = [responseObject objectForKey:@"list"];
            
            for (NSDictionary *dic in arr) {
                ConsigneeModel *con = [[ConsigneeModel alloc]initWithId:[dic objectForKey:@"id"] consignee:[dic objectForKey:@"consignee"] userPhone:[dic objectForKey:@"consigneePhone"] localtion:[dic objectForKey:@"localtion"] street:[dic objectForKey:@"street"] detailAddress:[dic objectForKey:@"detailedAddress"] addressID:[dic objectForKey:@"addressID"]];
                [_array addObject:con];
            }
            
        }else
        {
            Toast *toa = [Toast makeText:@"暂时没有收货地址信息"];
            [toa showWithType:ShortTime];
        }
        
        [self.tableView reloadData];
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [_buttonView removeFromSuperview];
}

-(void)addReciver:(UIButton *)sender
{
    AddReciverViewController *view = [[AddReciverViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
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
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressTableViewCell" owner:nil options:nil]firstObject];
    }
    
    cell.delegate = self;
    
    ConsigneeModel *con = _array[indexPath.row];
    
    cell.con = con;
    
    cell.name.text =con.consignee;
    cell.number.text = con.userPhone;
    cell.address.text = [NSString stringWithFormat:@"%@%@%@",con.localtion,con.street,con.detailAddress];
    
    return cell;
}



@end

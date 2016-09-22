//
//  CartTableViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "LoginViewController.h"
#import "CartTableViewController.h"
#import "CartTableViewCell.h"
#import "CommitOrderViewController.h"
#import "GoodsDetailViewController.h"
#import "GoodsModel.h"
#import "RDVTabBarController.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"

@interface CartTableViewController ()

@property(strong,nonatomic)MBProgressHUD *HUD;

@end

@implementation CartTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"购物车";
    
    self.tableview.tableFooterView = [[UIView alloc]init];
    
    self.arr = [NSMutableArray array];
    self.array = [[NSMutableArray alloc]init];
    self.selectArray = [[NSMutableArray alloc]init];
    self.mark = [[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"]) {
        
        Toast *toa = [Toast makeText:@"登录后才能查看此页面"];
        [toa showWithType:ShortTime];
        
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        
        return;
        
    }
    
    
    [self getData];

    
}

-(void)getData
{
    
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/selectMallShoppingCart.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [_selectArray removeAllObjects];
        [_arr removeAllObjects];
        [_array removeAllObjects];
        [_mark removeAllObjects];
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            
            NSArray *a = [responseObject objectForKey:@"list"];
            
            for (int i = 1; i <= a.count ; i++) {
                NSDictionary *dictionary = a[i-1];
                
                NSMutableDictionary* d = [NSMutableDictionary dictionaryWithCapacity:3];
                
                NSString *s = [dictionary objectForKey:@"commodityID"];
                [d setObject:s forKey:@"commodityID"];
                
                s = [dictionary objectForKey:@"id"];
                [d setObject:s forKey:@"id"];

                [_arr addObject:d];
                
                
                
                //获得每个商品的信息
                NSString *str = [NSString stringWithFormat:@"list%d",i];
                NSDictionary *dic = [[responseObject objectForKey:str]firstObject];
                
                NSNumber *num = [NSNumber numberWithInteger:[(NSString*)[dic objectForKey:@"id"] integerValue]];
                GoodsModel *good = [[GoodsModel alloc]initWhthID:num  Title:[dic objectForKey:@"name"] describe:[dic objectForKey:@"describe"] photo:[dic objectForKey:@"photo"] price:[dic objectForKey:@"retailPrice"] originalPrice:[dic objectForKey:@"originalPrice"] buyCount:[dic objectForKey:@"buyCount"] discount:[dic objectForKey:@"discount"] praiseCount:[dic objectForKey:@"praiseCount"] upFrame:[dic objectForKey:@"upFrame"] createTime:[dic objectForKey:@"createTime"]];
                NSInteger integer = [(NSString*)[dictionary objectForKey:@"commodityNumber"] integerValue];
                good.goodsNumber = [NSNumber numberWithInteger:integer];
                [_array addObject:good];
                
            }
            
            for (int i = 0; i < _array.count; i++) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:@"NO" forKey:@"checked"];
                [_mark addObject:dic];
            }
            
        }
        else
        {
            NSString *msg = [responseObject objectForKey:@"msg"];
            Toast *toa = [Toast makeText:msg];
            [toa showWithType:ShortTime];
        }
        
        [self.tableview reloadData];
        
    }];
    
    UIButton *button = [self.view viewWithTag:50];
    [button setSelected:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    
    [[NSUserDefaults standardUserDefaults]objectForKey:@"cart"];
    
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CartTableViewCell" owner:nil options:nil]firstObject];
    }
    
    for (int i = 1; i <= 3; i++) {
        [cell.contentView viewWithTag:i].layer.borderWidth = 1;
        [cell.contentView viewWithTag:i].layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    
    GoodsModel *goods = _array[indexPath.row];
    
    cell.goods = goods;
    
    cell.delegate = self;
    
    cell.name.text = goods.title;
        
    cell.price.text = [NSString stringWithFormat:@"¥%@",goods.price];
    
    cell.number.text = [NSString stringWithFormat:@"%@",goods.goodsNumber];
    
    
    cell.photo.layer.borderWidth = 1;
    cell.photo.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    NSArray *arr = [goods.photo componentsSeparatedByString:@"**"];
    NSURL *url = [NSURL URLWithString:[arr[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [cell.photo sd_setImageWithURL:url];
    
    NSMutableDictionary *dic = _mark[indexPath.row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        
    }else {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GoodsDetailViewController * goods = [[GoodsDetailViewController alloc]init];
    goods.goodsID = [_arr[indexPath.row] objectForKey:@"commodityID"];
    goods.good = _array[indexPath.row];
    [self.rdv_tabBarController.navigationController pushViewController:goods animated:YES];
}


- (IBAction)selectAll:(UIButton*)sender {
    
    [_mark removeAllObjects];
    
    if (sender.selected) {
        
        sender.selected = NO;
        [self. selectArray removeAllObjects];
        
        for (int i = 0; i <_array.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"NO" forKey:@"checked"];
            [_mark addObject:dic];
        }
        
    }else
    {
        sender.selected = YES;
        self.selectArray = [NSMutableArray arrayWithArray:self.array];
        
        for (int i = 0; i <_array.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"YES" forKey:@"checked"];
            [_mark addObject:dic];
        }
        
    }
    
    [self.tableview reloadData];
}

- (IBAction)deleteGoods:(id)sender {
    
    if (_selectArray.count == 0) {
        Toast *toa = [Toast makeText:@"请先选择商品再进行操作"];
        [toa showWithType:ShortTime];
        return;
    }
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.label.text = @"Loading";
    [_HUD showAnimated:YES];
    
    
    
    NSMutableString *passString = [NSMutableString string];
    for (GoodsModel *obj in _selectArray) {
        
        NSUInteger index = [_array indexOfObject:obj];
        
        if ([passString isEqualToString:@""]) {
            
            [passString appendFormat:@"%@",[_arr[index] objectForKey:@"id"]];
            
        }else
        {
            [passString appendFormat:@",%@",[_arr[index] objectForKey:@"id"]];
        }
        
    }
    
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setObject:passString forKey:@"id"];
    
    [[AFHTTPSessionManager manager] POST:@"http://123.57.28.11:8080/jfsc_app/deleteMallShoppingCart.do" parameters:pass success:^(NSURLSessionDataTask * ta, id responseObject) {
        
        [_HUD hideAnimated:NO];
        
        NSString *msg = [responseObject objectForKey:@"msg"];
        Toast *toast = [Toast makeText:msg];
        
        [self getData];
        
        
        [toast showWithType:ShortTime];
        
        
    } failure:^(NSURLSessionDataTask * ta, NSError * error) {
        
        [_HUD hideAnimated:NO];

        
        Toast *toast = [Toast makeText:@"网络连接失败,请稍后重试"];
        [toast showWithType:ShortTime];
    }];
    
    
}

- (IBAction)commitOrder:(id)sender {
    
    if (_selectArray.count == 0) {
        Toast *toa = [Toast makeText:@"请先选择商品再进行操作"];
        [toa showWithType:ShortTime];
        return;
    }
    
    CommitOrderViewController *commit = [[CommitOrderViewController alloc]init];
    
    commit.array = _selectArray;
    
    //有可能是从tab底层push页面，也有可能是从商品详情进的这个页面再push
    if (self.rdv_tabBarController) {
        [self.rdv_tabBarController.navigationController pushViewController:commit animated:YES];
    }else
    {
        [self.navigationController pushViewController:commit animated:YES];
    }
    
    
}


-(void)deselectedCellButtonWith:(UITableViewCell*)cell checked:(BOOL)flag
{
    NSIndexPath *index = [self.tableview indexPathForCell:cell];
    if (flag) {
        
        [_selectArray addObject:_array[index.row]];
        NSMutableDictionary *dic = [_mark objectAtIndex:index.row];
        [dic setObject:@"YES" forKey:@"checked"];
        
    }else
    {
        [_selectArray removeObject:_array[index.row]];
        NSMutableDictionary *dic = [_mark objectAtIndex:index.row];
        [dic setObject:@"NO" forKey:@"checked"];
        
    }
}

@end
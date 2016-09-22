//
//  SerchViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "SerchViewController.h"
#import "SearchTableViewCell.h"
#import "GoodsDetailViewController.h"

#import "GoodsModel.h"
#import "UIImageView+WebCache.h"
@interface SerchViewController ()

@end

@implementation SerchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
}

-(void)setData
{
    self.array = [NSMutableArray array];
    self.tableVeiw.tableFooterView = [[UIView alloc]init];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searGoods:)];
    self.navigationItem.rightBarButtonItem = right;
    
    //让searchbar取消键盘的点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.sear = [[UISearchBar alloc]initWithFrame:CGRectMake(40 , 7, kMainScreenWidth-90, 30)];
    [self.navigationController.navigationBar addSubview:_sear];
    _sear.placeholder = @"请输入搜索的关键字";
    _sear.delegate = self;
    
    //设置searchBar是否激活
    if (!_isSearchBarNOActivity) {
        [_sear becomeFirstResponder];
    }
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_sear endEditing:YES];
    
    [_sear removeFromSuperview];
    
}

-(void)endEdit:(UITapGestureRecognizer *)tap
{
    [_sear resignFirstResponder];
}

-(void)searGoods:(id)sender
{
    [_sear endEditing:YES];
    
    if ([self.sear.text isEqualToString:@""]) {
        Toast *toa = [Toast makeText:@"请输入关键字"];
        [toa showWithType:ShortTime];
        return;
    }
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:_sear.text forKey:@"name"];
    
    Network *net = [[Network alloc]init];
    [net accessNetUrl:URL_SEARCHGOODS parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            NSArray *arr = [responseObject objectForKey:@"list"];
            
            
            [_array removeAllObjects];
            for (NSDictionary *dic in arr) {
                                
                GoodsModel *good = [[GoodsModel alloc]initWhthID:[dic objectForKey:@"id"] Title:[dic objectForKey:@"name"] describe:[dic objectForKey:@"describe"] photo:[dic objectForKey:@"photo"] price:[dic objectForKey:@"retailPrice"] originalPrice:[dic objectForKey:@"originalPrice"] buyCount:[dic objectForKey:@"buyCount"] discount:[dic objectForKey:@"discount"] praiseCount:[dic objectForKey:@"praiseCount"] upFrame:[dic objectForKey:@"upFrame"] createTime:[dic objectForKey:@"createTime"]];
                [_array addObject:good];
            }
            
            [self.tableVeiw reloadData];
            
        }else if([[responseObject objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInteger:-1]])
        {
            NSString *alter = [responseObject objectForKey:@"msg"];
            Toast *toa = [Toast makeText:alter];
            [toa showWithType:ShortTime];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SearchTableViewCell" owner:nil options:nil]firstObject];
    }
    
    
    cell.delegate = self;
    
    GoodsModel *good = _array[indexPath.row];
    
    cell.goods = good;
    
    cell.price.text = [NSString stringWithFormat:@"¥%@", good.price];
    cell.describe.text = good.title;
    cell.buyCount.text = [NSString stringWithFormat:@"好评%@ %@人",good.praiseCount,good.buyCount];
    
    NSString *url = [good.photo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.photo sd_setImageWithURL:[NSURL URLWithString:url]];
                                   
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GoodsModel *good = _array[indexPath.row];
    
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc]init];
    
    vc.goodsID = good.goodsID;
    vc.good = good;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (IBAction)sortByTag:(UIButton *)sender {
    
    for (int i = 1; i <= 3; i++) {
        UIButton *btn = [self.view viewWithTag:i];
        if (i == sender.tag) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else
        {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
   
    NSArray *arr = [_array sortedArrayUsingComparator:^NSComparisonResult(GoodsModel *obj1, GoodsModel *obj2) {
        
        switch (sender.tag) {
            case 1:
                
                return [obj2.createTime compare:obj1.createTime];
                
            case 2:
                
                return [[NSNumber numberWithDouble:[(NSString*)obj2.buyCount doubleValue]] compare:[NSNumber numberWithDouble:[(NSString*)obj1.buyCount doubleValue]]];
                
            default:

                return [[NSNumber numberWithDouble:[(NSString*)obj1.price doubleValue]] compare:[NSNumber numberWithDouble:[(NSString*)obj2.price doubleValue]]];
                
        }
        
    }];
    
    self.array = [NSMutableArray arrayWithArray:arr];
    
    [self.tableVeiw reloadData];
   
}

@end

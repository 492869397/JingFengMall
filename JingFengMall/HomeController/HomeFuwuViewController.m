//
//  HomeFuwuViewController.m
//  JingFengMall
//
//  Created by len on 16/5/12.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeFuwuViewController.h"
#import "HomeSecondViewCell.h"
#import "HomeModel.h"
#import "AFNetworking.h"
#import "HomeThredViewController.h"
#define URL @"http://123.57.28.11:8080/jfsc_app/selectHTypeByTwo.do"

@interface HomeFuwuViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UIView *leftView;
@property (nonatomic ,strong)UITableView *rightTableView;
@property (nonatomic ,strong)NSMutableArray *array;
@property (nonatomic ,strong)NSDictionary *Dic;
@property (nonatomic ,strong)NSArray *leftArrayName;
@property (nonatomic ,strong)NSArray *ArrayName;
@property (nonatomic ,strong)UIButton *button;

@end

@implementation HomeFuwuViewController
NSInteger currentIndex = 7;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"全部服务";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.leftView];
    self.rightTableView.bounces = NO;

    self.leftArrayName = @[@"家庭清洁",@"保姆",@"月嫂",@"生活无忧",@"家具养护",@"运输",@"其他"];

    for (int i = 0; i < currentIndex; i++) {
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0 , i*41, SCREEN_WIDTH/4-1, 40)];
        _button.backgroundColor = [UIColor whiteColor];
        [_button setTitle:[_leftArrayName objectAtIndex:i] forState:(UIControlStateNormal)];
        _button.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [_button  setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
         _button.tag = 100+i;
        [_button addTarget:self action:@selector(doSth:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftView addSubview:self.button];
    }
    
    [self.leftView viewWithTag:_buttonTag].backgroundColor = [UIColor lightGrayColor];
    
    [self doSth:[self.leftView viewWithTag:_buttonTag]];
}


-(NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
-(NSDictionary *)Dic
{
    if (!_Dic) {
        _Dic = [NSDictionary dictionary];
    }
    return _Dic;
}

-(void)doSth:(UIButton *)sender
{
    NSMutableDictionary *params2=[NSMutableDictionary dictionary];

     if (sender.tag == 100) {
         NSLog(@"家庭清洁");
         params2[@"typeID"] = @"6";
     }
     else if (sender.tag ==101){
         NSLog(@"保姆");
         params2[@"typeID"] = @"1";
    }
     else if (sender.tag ==102){
         NSLog(@"月嫂");
         params2[@"typeID"] = @"5";
     }
     else if (sender.tag ==103){
         NSLog(@"生活无忧");
         params2[@"typeID"] = @"4";
     }
     else if (sender.tag ==104){
         NSLog(@"家庭养护");
         params2[@"typeID"] = @"3";
     }
     else if (sender.tag ==105){
         NSLog(@"运输");
         params2[@"typeID"] = @"2";
     }
     else{
         NSLog(@"其他");
         params2[@"typeID"] = @"7";
     }
    
    UIView *button =  [self.leftView viewWithTag:_buttonTag];
    if (button) {
        button.backgroundColor = [UIColor whiteColor];
    }
    
    self.buttonTag = sender.tag;
    
    [self.leftView viewWithTag:_buttonTag].backgroundColor = [UIColor lightGrayColor];
    
    AFHTTPRequestOperationManager *mgr2=[AFHTTPRequestOperationManager manager];
    [mgr2 POST:URL parameters:params2  success:^(AFHTTPRequestOperation * operation, id responsObject)
     {
         
         NSMutableArray *dataArray = [NSMutableArray arrayWithArray:responsObject[@"list"]];
        [self.array removeAllObjects];
         for (NSMutableDictionary *dict in dataArray) {
             findModel *model = [findModel initWithDict:dict];
             [self.array addObject:model];
             //NSString *Iid = dict[@"id"];
             //_priceTypeString = [NSString stringWithFormat:@"%@", Iid];
             //NSLog(@"%@",Iid);
             //NSLog(@"%@",responsObject);
            
         }
         [self.rightTableView reloadData];
         
     } failure:^(AFHTTPRequestOperation * operation, NSError * error)
     {
         
     }];
    
 }
-(UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 64, SCREEN_WIDTH-SCREEN_WIDTH/4, SCREEN_HEIGHT - 64)style:(UITableViewStylePlain)];
        _rightTableView.separatorColor = [UIColor lightGrayColor];
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.allowsSelection = YES;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        [_rightTableView registerNib:[UINib nibWithNibName:@"HomeSecondViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_rightTableView];
        
    }
    return _rightTableView;
}


-(UIView *)leftView{
    
    if (!_leftView) {
        _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH/4+1, currentIndex*40 + currentIndex)];
        
        _leftView.backgroundColor = [UIColor lightGrayColor];
    }
    return _leftView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark dalegte
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifer = @"cell";
    HomeSecondViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    findModel *model = self.array[indexPath.row];
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeThredViewController *HTVC = [[HomeThredViewController alloc]init];
    findModel *model = self.array[indexPath.row];
    _priceTypeString = [NSString stringWithFormat:@"%@", model.Iid];
    HTVC.priceTypeStr = _priceTypeString;
    NSLog(@"%@",model.Iid);
    [self.navigationController pushViewController:HTVC animated:NO];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
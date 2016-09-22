//
//  JingFengMoneyViewController.m
//  JingFengMall
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "JingFengMoneyViewController.h"
#import "JingFengMoneyTableViewCell.h"
#import "AttornView.h"

@interface JingFengMoneyViewController ()

@property (strong, nonatomic) UIView *headView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation JingFengMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.rowHeight = 69;
    
    self.title = @"京锋币";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.array = [NSMutableArray array];
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UIView *separet = [[UIView alloc]initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH-16, 0.3)];
    separet.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:separet];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH-20, 20)];
    label.text = @"没有更多明细了";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    [view addSubview:label];
    _tableView.tableFooterView = view;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self fresh];
}

-(void)fresh
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/selectUserByUserPhone.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            [_array removeAllObjects];
            
            _array = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"listMCoininfo"]];

            [_tableView reloadData];
        }else
        {
            Toast *toa = [Toast makeText:responseObject[@"msg"]];
            [toa showWithType:ShortTime];
        }
    }];
    
}




#pragma tableView DataSouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

#pragma tableView delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JingFengMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JingFengMoneyTableViewCell" owner:nil options:nil]firstObject];
        
        cell.contentView.bounds = CGRectMake(0 , 0, kMainScreenWidth, 140);
        
    }
    
    NSDictionary *dic = _array[indexPath.row];
    cell.title.text = dic[@"m_use"];
    cell.money.text = dic[@"useNumber"];
    
     NSDate *createTime = [NSDate dateWithTimeIntervalSince1970:((NSNumber*)[dic objectForKey:@"createTime"]).doubleValue/1000 ];
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy年MM月dd日 hh:mm:ss";
    NSString *s = [format stringFromDate:createTime];
    
    cell.time.text = s;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 250;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IMG_1252"]];
    image.frame = CGRectMake((SCREEN_WIDTH - 150 ) /2.0 , 15, 150, 150);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 150, 20)];
    label.tag = 50;
    label.textColor = [UIColor whiteColor];
    
    label.text = [NSString stringWithFormat:@"%.2f",_JingFengCoin.floatValue];
    label.textAlignment = NSTextAlignmentCenter;
    
    [image addSubview:label];

    [view addSubview:image];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"IMG_12522"] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 105, 35);
    
    button.center = CGPointMake(SCREEN_WIDTH/2, image.frame.origin.y + image.frame.size.height + 30);
    
    [button addTarget:self action:@selector(PayCarMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    UIView *seperat = [[UIView alloc]initWithFrame:CGRectMake(8, view.frame.size.height - 15, SCREEN_WIDTH - 16, 0.3)];
    seperat.backgroundColor = [UIColor lightGrayColor];
    
    [view addSubview:seperat];
    
    UILabel *headTile = [[UILabel alloc]init];
    headTile.text = @"余额明细";
    [headTile sizeToFit];
    headTile.center = CGPointMake(SCREEN_WIDTH/2, seperat.center.y);
    headTile.bounds = CGRectMake(0, 0, headTile.frame.size.width + 10, headTile.frame.size.height);
    headTile.textAlignment = NSTextAlignmentCenter;
    headTile.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:headTile];
    
    return view;
    
}



- (void)PayCarMoney:(UIButton *)sender {
    
    AttornView *att = [[[NSBundle mainBundle]loadNibNamed:@"AttornView" owner:nil options:nil]firstObject];
    
    att.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    att.delegate = self;
    
    [self.view addSubview:att];
    
}

@end

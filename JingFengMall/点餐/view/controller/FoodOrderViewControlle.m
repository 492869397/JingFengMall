//
//  FoodOrderViewControlle.m
//  JingFengMall
//
//  Created by len on 16/5/30.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "FoodOrderViewControlle.h"
#import "FoodOrderTableViewCell.h"

@interface FoodOrderViewControlle ()<UITableViewDelegate,UITableViewDataSource>
{
    UISegmentedControl *segment;
    NSInteger _recoderIndex;
}
@property (nonatomic ,strong)NSMutableArray *array;
@property (nonatomic ,strong)NSDictionary *Dic;
@property (nonatomic,strong)UITableView *orderTebleView;
@property (nonatomic ,strong)UIButton *DetailsBtn;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *OrderBtn;
@property (strong, nonatomic) IBOutlet UIButton *LottoBtn;
- (IBAction)OrderBtn:(id)sender;
- (IBAction)LottoBtn:(id)sender;

@end

@implementation FoodOrderViewControlle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self.view addSubview:self.orderTebleView];
    [self.orderTebleView addSubview:self.DetailsBtn];
    self.DetailsBtn.hidden = YES;
    [self.orderTebleView reloadData];

}
-(NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIButton *)DetailsBtn{
    if (!_DetailsBtn) {
        _DetailsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _DetailsBtn.frame = CGRectMake(-3, 114, SCREEN_WIDTH + 6 , 35);
        [_DetailsBtn setImage:[UIImage imageNamed:@"DetailsClick.png"] forState:(UIControlStateNormal)];
        [_DetailsBtn addTarget:self action:@selector(DetailsClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    return _DetailsBtn;
}
-(void)DetailsClick{

    NSLog(@"this");
}

-(UITableView *)orderTebleView{
    if (!_orderTebleView) {
        _orderTebleView = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStylePlain)];
        _orderTebleView.bounces = NO;
        _orderTebleView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _orderTebleView.allowsSelection = NO;
        _orderTebleView.dataSource = self;
        _orderTebleView.delegate = self;
        [_orderTebleView registerNib:[UINib nibWithNibName:@"FoodOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"FoodOrderCell"];
        
    }
    return _orderTebleView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *identifer = @"FoodOrderCell";
    FoodOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (_recoderIndex == 0) {
        
        [cell.contentView viewWithTag:1].hidden = NO;
        [cell.contentView viewWithTag:2].hidden = YES;
        [cell.contentView viewWithTag:3].hidden = NO;
        
    }else{
        
        [cell.contentView viewWithTag:1].hidden = YES;
        [cell.contentView viewWithTag:2].hidden = NO;
        [cell.contentView viewWithTag:3].hidden = YES;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // return self.array.count;
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 149;
    }
    return 120;
    
}

//接口
- (IBAction)OrderBtn:(id)sender {
    
    NSLog(@"1");
    [self.imageView setImage:[UIImage imageNamed:@"btn140.png"]];
    //[self NSStringStay:@"待完成"];
    _recoderIndex = 0;
    [_orderTebleView reloadData];
}

- (IBAction)LottoBtn:(id)sender {
    NSLog(@"2");
    [self.imageView setImage:[UIImage imageNamed:@"btn130.png"]];
    //[self NSStringStay:@"待评价"];
    _recoderIndex = 1;
    [_orderTebleView reloadData];

}
@end

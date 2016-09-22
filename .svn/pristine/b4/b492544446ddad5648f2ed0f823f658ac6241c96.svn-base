//
//  FoodViewController.m
//  JingFengMall
//
//  Created by len on 16/5/25.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "FoodViewController.h"
#import "FoodFirstTableViewCell.h"
#import "FoodSecondViewController.h"
@interface FoodViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSMutableArray *array;
@property (nonatomic ,strong)NSDictionary *Dic;
@property (strong ,nonatomic)UITableView *tableView;
@property (strong ,nonatomic)UIView *viewHeight;
@property (strong ,nonatomic)UIButton *btns;
@property (strong ,nonatomic)UILabel *lbls;
@property (strong ,nonatomic)UIView *myview;
@property (strong ,nonatomic)UIButton *buttons;





@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"就餐位置:****";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(rightBtn)];
   
    [self.view addSubview:self.tableView];

}
-(void)rightBtn{
    NSLog(@"!!!!!!!!!!!!");
    FoodSecondViewController *FSVC = [[FoodSecondViewController alloc]init];
    [self.navigationController pushViewController:FSVC animated:YES];
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 164, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStylePlain)];
        _tableView.bounces = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"FoodFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"FoodCell"];
    }
    return _tableView;
}
//-(UIView *)myview{
//    if (!_myview) {
//        _myview =[[UIView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 60)];
//        _myview.backgroundColor = [UIColor redColor];
//        for (int i = 0; i < 3; i++) {
//            _btns = [UIButton buttonWithType:(UIButtonTypeCustom)];
//            [_btns setFrame:CGRectMake(SCREEN_WIDTH/4*i + 20, 0, SCREEN_WIDTH/7, SCREEN_WIDTH/7)];
//            [_btns setBackgroundColor:[UIColor orangeColor]];
//            [self.myview addSubview:_btns];
//
//        }
//    }
//    return _myview;
//}
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


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"FoodCell";
    FoodFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
//    auntModel *model = self.array[indexPath.row];
//    cell.model = model;
    return cell;
}

//重新设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
      _viewHeight = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,130)];
      //viewHeight.backgroundColor = [UIColor orangeColor];
    
        for (int i = 0; i < 4; i++) {
            _btns = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [_btns setFrame:CGRectMake(SCREEN_WIDTH/4*i + 20, 5, SCREEN_WIDTH/7, SCREEN_WIDTH/7)];
            [_btns setBackgroundColor:[UIColor orangeColor]];
            [_viewHeight addSubview:_btns];
            _lbls = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*i + 20, self.btns.frame.size.height + 10, SCREEN_WIDTH/7, SCREEN_WIDTH/16)];
            _lbls.backgroundColor = [UIColor greenColor];
            _lbls.textAlignment = NSTextAlignmentCenter;
            [_viewHeight addSubview:_lbls];
           
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lbls.frame)+5, SCREEN_WIDTH, 30)];
        imageView.image = [UIImage imageNamed:@""];
        imageView.backgroundColor = [UIColor orangeColor];
        [_viewHeight addSubview:imageView];
        [_tableView setTableHeaderView:_viewHeight];
        _viewHeight.userInteractionEnabled = NO;
    }
    return nil;

}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 29;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.array.count;
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (void)viewWillAppear:(BOOL)animated

{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}


@end

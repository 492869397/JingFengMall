//
//  FoodSecondViewController.m
//  JingFengMall
//
//  Created by len on 16/5/27.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "FoodSecondViewController.h"
#import "FoodSecondTableViewCell.h"
#import "FoodLottoViewController.h"

@interface FoodSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UILabel *lblMenu;
- (IBAction)lottoBtn:(id)sender;


@property (strong, nonatomic) UILabel *showMenuTitlelbl;
@property (strong, nonatomic) UITableView *tableMenu;
@property (strong, nonatomic) UIButton *shopingBtn;

@end

@implementation FoodSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.showMenuTitlelbl];
    [self.view addSubview:self.tableMenu];
    [self.view addSubview:self.shopingBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lblMenu.frame), SCREEN_WIDTH/4, (SCREEN_HEIGHT-self.lblMenu.frame.size.height)-self.topView.frame.size.height-80)];
        _leftView.backgroundColor = [UIColor purpleColor];
        //循环生成leftbutton
    }
    return _leftView;
    
}
//排号
- (IBAction)lottoBtn:(id)sender {
    FoodLottoViewController *FLVC = [[FoodLottoViewController alloc]init];
    [self.navigationController pushViewController:FLVC animated:YES];
}

-(UILabel *)showMenuTitlelbl{
    if (!_showMenuTitlelbl) {
        _showMenuTitlelbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftView.frame), CGRectGetMaxY(self.lblMenu.frame), SCREEN_WIDTH-self.leftView.frame.size.width, 30)];
        _showMenuTitlelbl.backgroundColor = [UIColor lightGrayColor];
        _showMenuTitlelbl.text = @"leftClickTitle";
        _showMenuTitlelbl.textAlignment = NSTextAlignmentLeft;
    }
    return _showMenuTitlelbl;
}
-(UIButton *)shopingBtn{
    if (!_shopingBtn) {
        _shopingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_shopingBtn setFrame:CGRectMake(0, CGRectGetMaxY(self.leftView.frame), SCREEN_WIDTH, 80)];
        _shopingBtn.backgroundColor = [UIColor lightGrayColor];
        [_shopingBtn setTitle:@"您的购物车是空的" forState:(UIControlStateNormal)];
       
    }
    return _shopingBtn;
}
-(UITableView *)tableMenu{
    
    if (!_tableMenu) {
        
        _tableMenu = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, CGRectGetMaxY(self.showMenuTitlelbl.frame), SCREEN_WIDTH-SCREEN_WIDTH/4, SCREEN_HEIGHT-80)style:(UITableViewStylePlain)];
        _tableMenu.separatorColor = [UIColor lightGrayColor];
        _tableMenu.backgroundColor = [UIColor whiteColor];
        _tableMenu.allowsSelection = YES;
        _tableMenu.delegate = self;
        _tableMenu.dataSource = self;
        [_tableMenu registerNib:[UINib nibWithNibName:@"FoodSecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"Menucell"];
    }
    return _tableMenu;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   static NSString *identifer = @"Menucell";
    FoodSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
//    findModel *model = self.array[indexPath.row];
//    cell.model = model;
    
    return cell;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //return self.array.count;
    return 10;
}
-(void) viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = YES;
}

@end

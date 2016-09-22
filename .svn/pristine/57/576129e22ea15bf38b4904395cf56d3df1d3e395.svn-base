//
//  SelectServicerViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "SelectServicerViewController.h"
#import "SelectServicerTableViewCell.h"
#import "auntModel.h"
#define URL @"http://123.57.28.11:8080/jfsc_app/selectEmployeeByType.do"

@interface SelectServicerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView *TableView;

@end

@implementation SelectServicerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择雇员";
    [self.view addSubview:self.TableView];
    
    [self.TableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    NSMutableDictionary *params2=[NSMutableDictionary dictionary];
    params2[@"typeID"] = self.typeId;
    
    AFHTTPRequestOperationManager *mgr2=[AFHTTPRequestOperationManager manager];
    [mgr2 POST:URL parameters:params2  success:^(AFHTTPRequestOperation * operation, id responsObject)
     {
         if ([[responsObject objectForKey:@"code"] isEqualToNumber:@-1])
         {
             Toast *toast = [Toast makeText:@"该服务还没有相应的雇员"];
             [toast showWithType:ShortTime];

         }
         
         NSMutableArray *dataArray = [NSMutableArray arrayWithArray:responsObject[@"list"]];
         for (NSMutableDictionary *dict in dataArray) {
             auntModel *model = [auntModel initWithDict:dict];
             [self.array addObject:model];
            NSLog(@"ID = %@",model.Iid);
             /* {"code":-1,"msg":"该服务还没有相应的雇员！！！"}*/
             // NSString *Iid = dict[@"id"];
             // _priceTypeStr = [NSString stringWithFormat:@"%@", Iid];
             // NSLog(@"%@",Iid);
             // NSLog(@"%@",responsObject);
         }
                [self.TableView reloadData];
         
     } failure:^(AFHTTPRequestOperation * operation, NSError * error)
     {
         
     }];

}
-(UITableView *)TableView{
    if (!_TableView) {
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)style:(UITableViewStylePlain)];
        _TableView.separatorColor = [UIColor lightGrayColor];
        _TableView.backgroundColor = [UIColor whiteColor];
        _TableView.allowsSelection = NO;
        _TableView.delegate = self;
        _TableView.dataSource = self;
        [_TableView registerNib:[UINib nibWithNibName:@"SelectServicerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _TableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    SelectServicerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    auntModel *model = self.array[indexPath.row];
    cell.model = model;
    cell.NavController = self.navigationController;
    cell.myselectBlock = _myselectBlock;
    cell.myselectBlockTwo = _myselectBlockTwo;
    cell.typeID = _typeId;
    cell.lblName = _lblName;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.array.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end

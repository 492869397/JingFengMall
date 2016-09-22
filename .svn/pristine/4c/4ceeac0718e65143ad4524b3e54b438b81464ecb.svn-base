//
//  NearDiversViewController.m
//  JingFengMall
//
//  Created by len on 16/2/14.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "NearDiversViewController.h"
#import "NearByDiversViewController.h"

@interface NearDiversViewController ()

@end

@implementation NearDiversViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是乘客";
    
    self.tableView.rowHeight = 110;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    self.closeCars = [[NSMutableArray alloc]init];
    self.typeList = @[@"轿车",@"货车",@"电动车",@"三轮车",@"其他"];
    self.carType = @"轿车";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserLocation:) name:LOCATION_CHANGE object:nil];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self freshView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(freshView) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.timer invalidate];
}

-(void)freshView
{
    [self getCloseCars];
}

-(void)getUserLocation:(NSNotification*)sender
{
    self.curLocation = [sender.userInfo objectForKey:@"userLocation"];
}

//获取附近的车的位置
-(void)getCloseCars
{
    double lng = self.curLocation.location.coordinate.longitude;
    double lat = self.curLocation.location.coordinate.latitude;
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:_carType forKey:@"carType"];
    [pass setObject:[NSNumber numberWithDouble:lng] forKey:@"lng"];
    [pass setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    
    Network *net = [[Network alloc]init];
    [net accessNetUrl:URL_CLOSECARSBYTYPE parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            NSArray *carArray = [responseObject objectForKey:@"listTotal"];
            [self.closeCars removeAllObjects];
            for (NSDictionary *dic in carArray) {
                CarModel *model = [[CarModel alloc]initWithPhone:[dic objectForKey:@"userPhone"] carType:[dic objectForKey:@"carType"] carBrand:[dic objectForKey:@"carBrand"] carNumber:[dic objectForKey:@"carNumber"] carColor:[dic objectForKey:@"carColor"] location:CLLocationCoordinate2DMake(((NSNumber*)[dic objectForKey:@"lng"]).doubleValue, ((NSNumber*)[dic objectForKey:@"lai"]).doubleValue) Position:[dic objectForKey:@"pPosition"]];
                [self.closeCars addObject:model];
            }
            [self.tableView reloadData];
        }
    }];
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
    return self.closeCars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearByDiversViewController *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NearByDiversViewController" owner:nil options:nil]firstObject];
    }

    cell.index = indexPath.row;
    cell.delegate = self;
    cell.carMassage = self.closeCars[indexPath.row];
    [cell setContent];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44)];
    view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:235/255.0 alpha:1];
    
    self.buttonView = [[UIImageView alloc]initWithFrame:CGRectMake(_carTypeTag*kMainScreenWidth/5.0, 4, kMainScreenWidth/5.0, 35)];
    self.buttonView.image = [UIImage imageNamed:@"woshichengke3_03"];
    [view addSubview:self.buttonView];
    
    for (int i = 0; i < 5; i++) {
        UIButton *car = [[UIButton alloc]initWithFrame:CGRectMake(i*kMainScreenWidth/5.0, 0, kMainScreenWidth/5.0, 44)];
        car.tag = i;
        [car setTitle:self.typeList[i] forState:UIControlStateNormal];
        [car setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [car addTarget:self action:@selector(getCarByType:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:car];
    }
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getCarByType:(id)sender {
    [self.timer invalidate];
    
    self.carTypeTag = ((UIButton*)sender).tag;
    self.carType = self.typeList[_carTypeTag];
    //清楚数组
    [self.closeCars removeAllObjects];
    [self.tableView reloadData];
    [self freshView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(freshView) userInfo:nil repeats:YES];
}
@end

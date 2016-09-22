//
//  DiversListViewController.m
//  JingFengMall
//
//  Created by len on 16/1/25.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "DiversListViewController.h"
#import "NearByDiversViewController.h"
#import "DiverPositionViewController.h"

@interface DiversListViewController ()

@end

@implementation DiversListViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self offsetNavigationBar];
//    self.subviews = [[NSMutableArray alloc]init];
//    self.typeList = @[@"轿车",@"货车",@"电动车",@"三轮车",@"其他"];
//    self.carType = @"轿车";
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserLocation:) name:LOCATION_CHANGE object:nil];
//    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(freshView) userInfo:nil repeats:YES];
//}
//
//-(void)freshView
//{
//    [self getCloseCars];
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [self.timer invalidate];
//}
//
//-(void)initView
//{
//    for (UIView *VC in self.subviews) {
//        [VC removeFromSuperview];
//    }
//    
//    NearByDiversViewController *near;
//    CGFloat heightSingleView = 200;
//    for (int i=0; i<self.closeCars.count; i++) {
//        near = [[NearByDiversViewController alloc]init];
//        
//        //设置视图的大小
//        near.view.frame = CGRectMake(10, near.view.frame.size.height*i+20, kMainScreenWidth-20, heightSingleView-40);
//        near.view.layer.cornerRadius = 15;
//        near.view.layer.borderWidth = 1;
//        near.view.layer.borderColor = [[UIColor colorWithRed:231/255 green:231/255 blue:231/255 alpha:1] CGColor];
//        
//        //设置视图控制器的车辆信息
//        near.carMassage = self.closeCars[i];
//        
//        [self.scrollView addSubview:near.view];
//        [self.subviews addObject:near.view];
//    }
//    self.scrollView.contentSize = CGSizeMake(0,heightSingleView*self.closeCars.count);
//}
//
////获取附近的车的位置
//-(void)getCloseCars
//{
//    double lng = self.curLocation.location.coordinate.longitude;
//    double lat = self.curLocation.location.coordinate.latitude;
//    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
//    [pass setObject:_carType forKey:@"carType"];
//    [pass setObject:[NSNumber numberWithDouble:lng] forKey:@"lng"];
//    [pass setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
//    
//    Network *net = [[Network alloc]init];
//    [net accessNetUrl:URL_CLOSECARSBYTYPE parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
//            NSArray *carArray = [responseObject objectForKey:@"listTotal"];
//            [self.closeCars removeAllObjects];
//            for (NSDictionary *dic in carArray) {
//                CarModel *model = [[CarModel alloc]initWithPhone:[dic objectForKey:@"userPhone"] carType:[dic objectForKey:@"carType"] carBrand:[dic objectForKey:@"carBrand"] carNumber:[dic objectForKey:@"carNumber"] carColor:[dic objectForKey:@"carColor"] location:CLLocationCoordinate2DMake(((NSNumber*)[dic objectForKey:@"lng"]).doubleValue, ((NSNumber*)[dic objectForKey:@"lai"]).doubleValue)];
//                [self.closeCars addObject:model];
//            }
//            [self initView];
//        }
//    }];
//}
//
//-(void)getUserLocation:(NSNotification*)sender
//{
//    self.curLocation = [sender.userInfo objectForKey:@"userLocation"];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (IBAction)switchCar:(id)sender {
//    self.carType = [self.typeList objectAtIndex:((UIButton*)sender).tag];
//    [self freshView];
//}
//
@end

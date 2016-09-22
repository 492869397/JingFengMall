//
//  GetCarViewController.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "GetCarViewController.h"
#import "NearDiversViewController.h"
#import "SelectWayViewController.h"
#import "AppDelegate.h"
#import "OrderTableViewController.h"

@interface GetCarViewController ()

@end

@implementation GetCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是乘客";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"订单" style:UIBarButtonItemStylePlain target:self action:@selector(enterOrderView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.closeCars = [[NSMutableArray alloc]init];
    self.isShouldUseSelfPosition = YES;
    self.startPT = @"点击选择起点";
    self.endPT = @"点击选择终点";
    self.annotationArray = [[NSMutableArray alloc]init];
    self.isUseAnnotation1 = YES;
    self.typeList = @[@"轿车",@"货车",@"电动车",@"三轮车",@"其他"];
    self.carPicList = @[@"img_car1",@"img_car4",@"img_car3",@"img_car2",@"img_car5"];
    self.carTypeTag = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserLocation:) name:LOCATION_CHANGE object:nil];
    
    self.carType = self.typeList[_carTypeTag];
    
    //获取附近车主位置信息
    [self getDiverLocation];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(getDiverLocation) userInfo:nil repeats:YES];
    
    self.userSearch = [[BMKGeoCodeSearch alloc]init];
    self.userSearch.delegate = self;
    
    self.curCity = [[NSUserDefaults standardUserDefaults]objectForKey:@"curCity"];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUnfinishedOrder"]) {
        UIButton *sender = (UIButton*)[self.view viewWithTag:50];
        [sender setEnabled:NO];
        [sender setTitle:@"已下单" forState:(UIControlStateDisabled)];
        Toast *toast = [Toast makeText:@"你有未完成的订单,请等待订单完成或者取消订单后再下订单"];
        [toast showWithType:LongTime];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self initMapSet];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.map.delegate = nil;
    [self.timer invalidate];
    self.userSearch = nil;
}

-(void)initMapSet
{
    
    CGRect s =  self.mapView.frame;
    CGRect mapSize = CGRectMake(0,0, s.size.width, s.size.height);
    self.map = [[BMKMapView alloc]initWithFrame:mapSize];
    [self.mapView addSubview:_map];
    
    CGPoint p = [self.mapView convertPoint:self.mapView.center toView:[UIApplication sharedApplication].delegate.window];
    [self.map setMapCenterToScreenPt:p];
    
    self.map.delegate = self;
    [self.map setUserTrackingMode:BMKUserTrackingModeNone];
    _map.showsUserLocation = YES;

    _map.rotateEnabled = NO;
    _map.showMapScaleBar = YES;
    _map.zoomLevel = 12;
    
    //刷新起点和终点标注的显示
    [self freshStartAndEndAnno];
}

-(void)enterOrderView
{
    OrderTableViewController *order = [[OrderTableViewController alloc]init];
    [self.navigationController pushViewController:order animated:YES];
}

-(void)freshStartAndEndAnno
{
    [self.endPoint setTitle:self.endPT forState:UIControlStateNormal];
    [self.endPoint.titleLabel sizeToFit];
    [self.startPoint setTitle:self.startPT forState:UIControlStateNormal];
    [self.startPoint.titleLabel sizeToFit];
    
    //起点
    if (![self.startPT isEqualToString:@"点击选择起点"]) {
        [_map removeAnnotation:self.annotation1];
        self.annotation1 = [[BMKPointAnnotation alloc]init];
        self.annotation1.coordinate = CLLocationCoordinate2DMake(self.startLat.doubleValue, self.startLng.doubleValue);
        self.annotation1.title = @"起点";
//        self.annotation1.subtitle = @"点击地图可选择终点";
        [_map addAnnotation:self.annotation1];
    }else
    {
        [_map removeAnnotation:self.annotation1];
        self.annotation1 = [[BMKPointAnnotation alloc]init];
        self.annotation1.coordinate = self.curLocation.location.coordinate;
        self.annotation1.title = @"起点";
        //        self.annotation1.subtitle = @"点击地图可选择终点";
        [_map addAnnotation:self.annotation1];
    }
    //终点
    if (![self.endPT isEqualToString:@"点击选择终点"]) {
        [_map removeAnnotation:self.annotation2];
        self.annotation2 = [[BMKPointAnnotation alloc]init];
        self.annotation2.coordinate = CLLocationCoordinate2DMake(self.endLat.doubleValue, self.endLng.doubleValue);
        self.annotation2.title = @"终点";
        self.annotation2.subtitle = @"点击地图可选择终点";
        [_map addAnnotation:self.annotation2];
    }
    [self setAutoMapCenter];
}

-(void)setAutoMapCenter
{
    CLLocationCoordinate2D coor ;
    if (self.endLat.doubleValue > 10 ) {
        coor = CLLocationCoordinate2DMake(self.endLat.doubleValue, self.endLng.doubleValue);
    }
    else
    {
        coor = CLLocationCoordinate2DMake(self.startLat.doubleValue, self.startLng.doubleValue);
    }
    [_map setCenterCoordinate:coor];
}

//在appdelegete中通过通知陆续调用
-(void)getUserLocation:(NSNotification*)sender
{
    self.curLocation = [sender.userInfo objectForKey:@"userLocation"];
    [_map updateLocationData:_curLocation];
    
    if (self.isShouldUseSelfPosition) {
        NSString *position = ((AppDelegate*)[UIApplication sharedApplication].delegate).curPosition;
        if (position) {
            self.startPT = position;
            CLLocationCoordinate2D location = self.curLocation.location.coordinate;
            self.startLat = [NSNumber numberWithDouble:location.latitude];
            self.startLng = [NSNumber numberWithDouble:location.longitude];
            
            //地图中心设置为定位的位置
            [self.map setCenterCoordinate:location animated:YES];
            
            [self freshStartAndEndAnno];
            
            self.isShouldUseSelfPosition = NO;
        }else
        {
            Toast *toast = [Toast makeText:@"连接地图服务器异常,地图服务功能请等待连接稳定后使用"];
            [toast showWithType:ShortTime];
        }
    }
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (searcher == self.userSearch)
    {
        if (error == BMK_SEARCH_NO_ERROR) {
            self.endPT = [NSString stringWithFormat:@"%@,%@",result.addressDetail.district,result.addressDetail.streetName];
            self.endLat = [NSNumber numberWithDouble:result.location.latitude];
            self.endLng = [NSNumber numberWithDouble:result.location.longitude];
            [self.endPoint setTitle:self.endPT forState:UIControlStateNormal];
            [self.endPoint.titleLabel sizeToFit];
        }
    }
}

-(void)displayDivers
{
    [_map removeAnnotations:self.annotationArray];
    for (CarModel *car in self.closeCars) {
        BMKPointAnnotation *carpic = [[BMKPointAnnotation alloc]init];
        carpic.coordinate = car.location;
        [_map addAnnotation:carpic];
        [self.annotationArray addObject:carpic];
    }
}

//从网络获取附近车主位置
-(void)getDiverLocation
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
                double lng = ((NSNumber*)[dic objectForKey:@"lng"]).doubleValue;
                double lat = ((NSNumber*)[dic objectForKey:@"lat"]).doubleValue;
                CarModel *model = [[CarModel alloc]initWithPhone:[dic objectForKey:@"userPhone"] carType:[dic objectForKey:@"carType"] carBrand:[dic objectForKey:@"carBrand"] carNumber:[dic objectForKey:@"carNumber"] carColor:[dic objectForKey:@"carColor"] location:CLLocationCoordinate2DMake(lat,lng) Position:[dic objectForKey:@"pPosition"]];
                [self.closeCars addObject:model];
            }
            [self displayDivers];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 实现地图的代理方法
-(BMKAnnotationView*)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if (annotation == self.annotation1) {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            // 设置可拖拽
            annotationView.draggable = YES;
        }
        return annotationView;
    }else if (annotation == self.annotation2)
    {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorRed;
            // 设置可拖拽
            annotationView.draggable = YES;
        }
        return annotationView;
    }
    else{
        NSString *annotationReuse = @"reuse";
        CarAnnotation *anoView = (CarAnnotation*)[_map dequeueReusableAnnotationViewWithIdentifier:annotationReuse];
        if (!anoView) {
            anoView = [[CarAnnotation alloc]initWithAnnotation:annotation reuseIdentifier:annotationReuse];
        }
        [anoView setCarPic:[UIImage imageNamed:self.carPicList[_carTypeTag]]];
        return anoView;
    }
}

//当点击地图某一点的时候
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = coordinate;
    [self.userSearch reverseGeoCode:option];
    //添加标注
    [self addPointAnnotation:coordinate];
}

//添加起点终点的标注
- (void)addPointAnnotation:(CLLocationCoordinate2D)coor
{
        [_map removeAnnotation:self.annotation2];
        self.annotation2 = [[BMKPointAnnotation alloc]init];
        self.annotation2.coordinate = coor;
        self.annotation2.title = @"终点";
        self.annotation2.subtitle = @"点击地图可选择终点";
        [_map addAnnotation:self.annotation2];
}

#pragma 实现按钮的响应方法
- (IBAction)confirm:(id)sender {
    if ([self isStartPTAndEndPtSelect]) {
        [self commitOrder:sender];
    }else
    {
        Toast *toast = [Toast makeText:@"请选择起点和终点位置"];
        [toast showWithType:ShortTime];
    }
}

-(BOOL)isStartPTAndEndPtSelect
{
    return  !(_startPT == nil || [_startPT isEqualToString:@""] || [_startPT isEqualToString:@"点击选择起点"]||_endPT == nil || [_endPT isEqualToString:@""] || [_endPT isEqualToString:@"点击选择终点"]);
}

-(void)commitOrder:(id)sender
{
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:ACCOUNT];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:self.startLng forKey:@"startLng"];
    [pass setObject:self.startLat forKey:@"startLat"];
    [pass setObject:self.startPT forKey:@"startPosition"];
    [pass setObject:self.endLng forKey:@"endLng"];
    [pass setObject:self.endLat forKey:@"endLat"];
    [pass setObject:self.endPT forKey:@"endPosition"];
    [pass setObject:phoneNumber forKey:@"orderUserPhone"];
    
    Network *net = [[Network alloc]init];
    [net accessNetUrl:URL_COMMITORDER parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
            [(UIButton*)sender setTitle:@"已下单" forState:UIControlStateDisabled];
            [(UIButton*)sender setEnabled:NO];

            NSNumber *orderId = [responseObject objectForKey:@"id"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUnfinishedOrder"];
            [[NSUserDefaults standardUserDefaults]setObject:orderId forKey:@"orderId"];
            //给代理发送通知,开始接收订单是否被接收的信息
            [[NSNotificationCenter defaultCenter]postNotificationName:ORDERBYRECIVED object:nil];
            
            Toast *toast = [Toast makeText:@"下单成功,可主动查看附近司机进行联系"];
            [toast showWithType:LongTime];
        }
    }];
}

- (IBAction)lookDiverList:(id)sender {
    
    NearDiversViewController *diver = [[NearDiversViewController alloc]init];
    diver.closeCars = self.closeCars;
    diver.curLocation = self.curLocation;
    diver.carType = _carType;
    [self.navigationController pushViewController:diver animated:YES];
    
}

- (IBAction)selectPlace:(id)sender {
    
    SelectWayViewController *view = [[SelectWayViewController alloc]init];
    view.curCity = self.curCity;
    view.delegate = self;
    view.senderTag = [(UIButton*)sender tag];
    [self presentViewController:view animated:YES completion:nil];
//    [self.navigationController pushViewController:view animated:YES];
    
}

- (IBAction)getCarByType:(id)sender {
    [self.timer invalidate];
    
    self.buttonView.center = ((UIButton*)sender).center;
    
    self.carTypeTag =((UIButton*)sender).tag;
    self.carType = self.typeList[_carTypeTag];
    [_map removeAnnotations:self.annotationArray];
    [self getDiverLocation];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getDiverLocation) userInfo:nil repeats:YES];
}

@end

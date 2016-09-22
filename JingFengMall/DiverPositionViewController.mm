//
//  DiverPositionViewController.m
//  JingFengMall
//
//  Created by len on 16/1/25.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "DiverPositionViewController.h"
#import "CarAnnotation.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface DiverPositionViewController ()

@end

@implementation DiverPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定位信息";
    self.carType = @"img_car1";
    self.carPicList = @[@"img_car1",@"img_car2",@"img_car3",@"img_car4",@"img_car5"];
    [self getCarType];
    
    _isShouldChangeCenter = YES;
    
    self.targetPosition.text = self.order.startPosition;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_map viewWillAppear];
    [self getDiversLocation];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(getDiversLocation) userInfo:nil repeats:YES];
    self.isFirstDisplay = YES;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self initView];
    self.search = [[BMKRouteSearch alloc]init];
    self.search.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_map viewWillDisappear];
    [self.timer invalidate];
    self.search.delegate = nil;
    
}

-(void)initView
{
    self.map = [[BMKMapView alloc]initWithFrame:self.mapview.bounds];
    [self.mapview addSubview:_map];
    CGPoint p = [self.mapview convertPoint:self.mapview.center toView:[UIApplication sharedApplication].delegate.window];
    [self.map setMapCenterToScreenPt:p];
    
    _map.rotateEnabled = NO;
    _map.showMapScaleBar = YES;
    _map.zoomLevel = 12;
    self.map.delegate = self;
}

-(void)getCarType
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:self.order.receiveUserPhone forKey:@"userPhone"];
    [net accessNetUrl:URL_GETSELFCARMASSAGE parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            NSString *car = [[[responseObject objectForKey:@"list"] objectAtIndex:0] objectForKey:@"carType"];
            if ([car isEqualToString:@"轿车"]) {
                self.carType = self.carPicList[0];
            }else if([car isEqualToString:@"三轮车"])
            {
                self.carType = self.carPicList[1];
            }else if ([car isEqualToString:@"电动车"])
            {
                self.carType = self.carPicList[2];
            }else if ([car isEqualToString:@"货车"])
            {
                self.carType = self.carPicList[3];
            
            }else
            {
                self.carType = self.carPicList[4];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayDiverByCLLocation:(CLLocationCoordinate2D)location
{
    if (_isShouldChangeCenter) {
        
        [self.map setCenterCoordinate:location animated:YES];
        _isShouldChangeCenter = NO;
        
    }
    
    
    
    [_map removeAnnotations:_map.annotations];

    //起点
    self.startPT = [[BMKPointAnnotation alloc]init];
    self.startPT.coordinate = CLLocationCoordinate2DMake(self.order.startLat, self.order.startLng);
    self.startPT.title = @"起点";
    [_map addAnnotation:self.startPT];
    //终点
    BMKPointAnnotation *carpic = [[BMKPointAnnotation alloc]init];
    carpic.coordinate = location;
    carpic.title = @"司机";
    [_map addAnnotation:carpic];
    
}

-(void)getDiversLocation
{
    Network *net = [[Network alloc]init];
    
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    
    [pass setObject:self.phoneNumber forKey:@"userPhone"];
    
    [net accessNetUrl:URL_GETONESPOSITION parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            NSDictionary *dic = [[responseObject objectForKey:@"list"]firstObject];
            CLLocationCoordinate2D location = CLLocationCoordinate2DMake( ((NSNumber*)[dic objectForKey:@"lat"]).doubleValue, ((NSNumber*)[dic objectForKey:@"lng"]).doubleValue);
            [self displayDiverByCLLocation:location];
            self.nowPosition.text = [dic objectForKey:@"pPosition"];
            
            //路径规划
            BMKDrivingRoutePlanOption *option = [[BMKDrivingRoutePlanOption alloc]init];
            BMKPlanNode *start = [[BMKPlanNode alloc]init];
            start.pt = location;
            BMKPlanNode *end = [[BMKPlanNode alloc]init];
            end.pt =CLLocationCoordinate2DMake(self.order.startLat, self.order.startLng);
            option.from = start;
            option.to = end;
            [self.search drivingSearch:option];
        }
    }];
}

#pragma 实现地图的代理方法
-(BMKAnnotationView*)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if (self.startPT == annotation) {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            // 从天上掉下效果
            annotationView.animatesDrop = NO;
            // 设置可拖拽
            annotationView.draggable = NO;
        }
        return annotationView;
    }else
    {
        NSString *annotationReuse = @"reuse";
        CarAnnotation *anoView = (CarAnnotation*)[_map dequeueReusableAnnotationViewWithIdentifier:annotationReuse];
        if (!anoView) {
            anoView = [[CarAnnotation alloc]initWithAnnotation:annotation reuseIdentifier:annotationReuse];
        }
        [anoView setCarPic:[UIImage imageNamed:self.carType]];
        return anoView;
    }
}

#pragma 路线规划代理
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        
        [_map removeOverlays:_map.overlays];
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_map addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        if (self.isFirstDisplay) {
            [self mapViewFitPolyLine:polyLine];
            self.isFirstDisplay = NO;
        }
    }
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 5.0;
        return polylineView;
    }
    return nil;
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_map setVisibleMapRect:rect];
    _map.zoomLevel = _map.zoomLevel - 0.3;
}

@end

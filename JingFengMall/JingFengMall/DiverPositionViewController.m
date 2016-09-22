//
//  DiverPositionViewController.m
//  JingFengMall
//
//  Created by len on 16/1/25.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "DiverPositionViewController.h"
#import "CarAnnotation.h"

@interface DiverPositionViewController ()

@end

@implementation DiverPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self initView];
}

-(void)initView
{
    self.map = [[BMKMapView alloc]initWithFrame:self.mapview.bounds];
    [self.mapview addSubview:_map];
    CGPoint p = [self.mapview convertPoint:self.mapview.center toView:[UIApplication sharedApplication].delegate.window];
    [self.map setMapCenterToScreenPt:p];
    self.map.delegate = self;
    
    [self displayDivers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayDivers
{
    [_map removeAnnotations:_map.annotations];
    
    BMKPointAnnotation *carpic = [[BMKPointAnnotation alloc]init];
    carpic.coordinate = [self getDiversLocation];
    [_map addAnnotation:carpic];
}

-(CLLocationCoordinate2D)getDiversLocation
{
    return CLLocationCoordinate2DMake(39.915, 116.404);
}

#pragma 实现地图的代理方法
-(BMKAnnotationView*)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    NSString *annotationReuse = @"reuse";
    CarAnnotation *anoView = (CarAnnotation*)[_map dequeueReusableAnnotationViewWithIdentifier:annotationReuse];
    if (!anoView) {
        anoView = [[CarAnnotation alloc]initWithAnnotation:annotation reuseIdentifier:annotationReuse];
    }
    [anoView setCarPic:[UIImage imageNamed:@"car_1"]];
    return anoView;
}

@end

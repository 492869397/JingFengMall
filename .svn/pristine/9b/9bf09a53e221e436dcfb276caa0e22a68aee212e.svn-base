//
//  DiverPositionViewController.h
//  JingFengMall
//
//  Created by len on 16/1/25.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "OrderModel.h"

@interface DiverPositionViewController : UIViewController<BMKMapViewDelegate,BMKRouteSearchDelegate>

@property(copy,nonatomic)NSString *phoneNumber;
@property(assign,nonatomic)CLLocationCoordinate2D location;
@property(strong,nonatomic)OrderModel *order;
//车主车辆类型
@property(copy,nonatomic)NSString *carType;
@property(strong,nonatomic)NSArray *carPicList;
@property(assign,nonatomic)BOOL isFirstDisplay;

@property(strong,nonatomic)BMKRouteSearch *search;

@property(strong,nonatomic)NSTimer *timer;
@property (strong, nonatomic) IBOutlet UIView *mapview;
@property(strong,nonatomic)BMKMapView *map;


@property(assign,nonatomic)BOOL isShouldChangeCenter;

//起点标注
@property(strong,nonatomic)BMKPointAnnotation *startPT;

@property (strong, nonatomic) IBOutlet UILabel *nowPosition;
@property (strong, nonatomic) IBOutlet UILabel *targetPosition;

@end

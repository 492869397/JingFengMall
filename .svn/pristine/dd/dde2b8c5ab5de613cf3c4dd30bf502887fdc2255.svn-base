//
//  PositionViewController.h
//  JingFengMall
//
//  Created by mac on 16/6/16.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "HomeOrderModel.h"
#import "CarAnnotation.h"

@interface PositionViewController : UIViewController<BMKMapViewDelegate,BMKRouteSearchDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewForMap;

@property(strong,nonatomic)BMKMapView *map;

@property(strong,nonatomic)BMKRouteSearch *search;

@property(copy,nonatomic)NSString *carType;

@property(assign,nonatomic)BOOL isShouldChangeCenter;

@property(strong,nonatomic)NSTimer *timer;

@property(strong,nonatomic)HomeOrderModel *order;



@property(strong,nonatomic)BMKPointAnnotation *startPT;
@property(assign,nonatomic)float lat;
@property(assign,nonatomic)float lng;


@property(assign,nonatomic)BOOL isFirstDisplay;


@property (strong, nonatomic) IBOutlet UILabel *msg;

@end

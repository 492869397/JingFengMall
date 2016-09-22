//
//  GetCarViewController.h
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//


#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "CarAnnotation.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "CarModel.h"

@interface GetCarViewController : UIViewController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate>

//用户主动点选的BMKGeoCodeSearch
@property(strong,nonatomic)BMKGeoCodeSearch *userSearch;

//进行不断的更新网咯上的位置
@property(strong,nonatomic)NSTimer *timer;
@property(copy,nonatomic)NSString *carType;
@property(strong,nonatomic)NSArray *typeList;
@property(strong,nonatomic)NSArray *carPicList;

@property(assign,nonatomic)NSInteger carTypeTag;

@property(strong,nonatomic)NSMutableArray *closeCars;
@property(strong,nonatomic)BMKUserLocation *curLocation;
@property(strong,nonatomic)IBOutlet UIView *mapView;
@property(strong,nonatomic)NSMutableArray *annotationArray;

@property(strong,nonatomic)BMKMapView *map;
@property(strong,nonatomic)NSArray *divers;
@property(strong,nonatomic)BMKAnnotationView *carAno;//车的标注
@property(strong,nonatomic)IBOutlet UIButton *startPoint;
@property(copy,nonatomic)NSString *startPT;
@property(strong,nonatomic)NSNumber *startLng;
@property(strong,nonatomic)NSNumber *startLat;

@property(strong, nonatomic) IBOutlet UIButton *endPoint;
@property(copy,nonatomic)NSString *endPT;
@property(strong,nonatomic)NSNumber *endLng;
@property(strong,nonatomic)NSNumber *endLat;

//中转变量,存储起点或者终点的信息
@property(copy,nonatomic)NSString *transitPT;
@property(copy,nonatomic)NSNumber *transitLng;
@property(copy,nonatomic)NSNumber *transitLat;

@property(copy,nonatomic)NSString *curCity;
@property(assign,nonatomic)BOOL isShouldUseSelfPosition;

//起点终点的Annotation
@property(assign,nonatomic)BOOL isUseAnnotation1;
@property(strong,nonatomic)BMKPointAnnotation *annotation1;
@property(strong,nonatomic)BMKPointAnnotation *annotation2;
//按钮下面的view
@property (strong, nonatomic) IBOutlet UIImageView *buttonView;

- (IBAction)confirm:(id)sender;
- (IBAction)lookDiverList:(id)sender;
- (IBAction)selectPlace:(id)sender;

- (IBAction)getCarByType:(id)sender;

@end

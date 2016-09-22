//
//  AppDelegate.h
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "Network.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKGeneralDelegate>

@property(strong,nonatomic)BMKMapManager *mapManager;
@property(strong,nonatomic)BMKLocationService *locationManager;
@property(strong,nonatomic)BMKGeoCodeSearch *geosearch;
//是否是启动后第一次初始化操作
@property(assign,nonatomic)BOOL isFirstInit;
//当前经纬度
@property(assign,nonatomic)double lat;
@property(assign,nonatomic)double lng;
//当前位置
@property(copy,nonatomic)NSString *curPosition;

@property(strong,nonatomic)NSTimer *orderTimer;
@property(strong,nonatomic)NSTimer *locationTimer;
@property(strong,nonatomic) UIWindow *window;
@property(copy,nonatomic)NSString *curCity;

@property(strong,nonatomic) AFHTTPSessionManager *session;

//百度地图鉴权
-(void)baiduMapPermisson;
@end


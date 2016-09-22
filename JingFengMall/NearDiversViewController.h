//
//  NearDiversViewController.h
//  JingFengMall
//
//  Created by len on 16/2/14.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "CarModel.h"

@interface NearDiversViewController : UITableViewController

@property(strong,nonatomic)NSMutableArray *closeCars;

@property(strong,nonatomic)BMKUserLocation *curLocation;
@property(copy,nonatomic)NSString *carType;
@property(strong,nonatomic)NSTimer *timer;
@property(strong,nonatomic)NSArray *typeList;
@property(assign,nonatomic)NSInteger carTypeTag;

@property(strong,nonatomic)UIImageView *buttonView;

@end

//
//  auntInfoModel.h
//  JingFengMall
//
//  Created by len on 16/5/17.
//  Copyright © 2016年 yunlan. All rights reserved.
//
/*
 "id": 1,
 "onTime": 5,
 "arg": 25,
 "certificate": "无",
 "price": "100元/小时",
 "appearance": 5,
 "birthplace": "北京",
 "neat": 5,
 "name": "李阿姨",
 "score": 5,
 "serviceCount": 2,
 "label": "神准时 5,整洁 5,",
 "photo": "http://123.57.28.11:8080/jfsc_app/images/bj1.jpg"

 */
#import <Foundation/Foundation.h>

@interface auntInfoModel : NSObject


@property (nonatomic ,copy)NSNumber *Iid;
@property (nonatomic ,copy)NSNumber *onTime;
@property (nonatomic ,copy)NSNumber *arg;
@property (nonatomic ,copy)NSString *certificate;
@property (nonatomic ,copy)NSString *price;
@property (nonatomic ,copy)NSNumber *appearance;
@property (nonatomic ,copy)NSString *birthplace;
@property (nonatomic ,copy)NSNumber *neat;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSNumber *score;
@property (nonatomic ,copy)NSNumber *serviceCount;
@property (nonatomic ,copy)NSString *label;
@property (nonatomic ,copy)NSNumber *photo;




-(instancetype)initWithDict:(NSDictionary *)dic;
+(instancetype)initWithDict:(NSDictionary *)dic;

@end

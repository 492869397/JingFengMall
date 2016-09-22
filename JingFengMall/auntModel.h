//
//  auntModel.h
//  JingFengMall
//
//  Created by len on 16/5/14.
//  Copyright © 2016年 yunlan. All rights reserved.
//
/*
 "id": 2,
 "price": "100元/小时",
 "name": "赵阿姨",
 "score": 5,
 "label": "神准时,整洁,",
 "photo": "http://123.57.28.11:8080/jfsc_app/images/bj2.jpg"
 
 */


#import <Foundation/Foundation.h>

@interface auntModel : NSObject

@property (nonatomic ,copy)NSNumber *Iid;
@property (nonatomic ,copy)NSString *price;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSNumber *score;
@property (nonatomic ,copy)NSString *label;
@property (nonatomic ,copy)NSString *photo;
//****
@property (nonatomic ,copy)NSString *label1;

-(instancetype)initWithDict:(NSDictionary *)dic;
+(instancetype)initWithDict:(NSDictionary *)dic;

@end

//
//  auntInfoModel.m
//  JingFengMall
//
//  Created by len on 16/5/17.
//  Copyright © 2016年 yunlan. All rights reserved.
//
/*
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
 */
#import "auntInfoModel.h"

@implementation auntInfoModel


-(instancetype)initWithDict:(NSDictionary *)dic
{
    
    if ( self = [super init])
    {
        self.Iid = dic[@"id"];
        self.onTime = dic[@"onTime"];
        self.arg = dic[@"arg"];
        self.certificate = dic[@"certificate"];
        self.price = dic[@"price"];
        self.appearance = dic[@"appearance"];
        self.birthplace = dic[@"birthplace"];
        self.neat = dic[@"neat"];
        self.name = dic[@"name"];
        self.score = dic[@"score"];
        self.serviceCount = dic[@"serviceCount"];
        self.label = dic[@"label"];
        self.photo = dic[@"photo"];
       
    }
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dic
{
    return [[self alloc]initWithDict:dic];
}


@end

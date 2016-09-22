//
//  auntModel.m
//  JingFengMall
//
//  Created by len on 16/5/14.
//  Copyright © 2016年 yunlan. All rights reserved.
//

/*
 @property (nonatomic ,copy)NSNumber *Iid;
 @property (nonatomic ,copy)NSString *price;
 @property (nonatomic ,copy)NSString *name;
 @property (nonatomic ,copy)NSNumber *score;
 @property (nonatomic ,copy)NSString *label;
 @property (nonatomic ,copy)NSString *photo;*/
#import "auntModel.h"

@implementation auntModel

-(instancetype)initWithDict:(NSDictionary *)dic
{
    
    if ( self = [super init])
    {
        self.Iid = dic[@"id"];
        self.price = dic[@"price"];
        self.name = dic[@"name"];
        self.score = dic[@"score"];
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

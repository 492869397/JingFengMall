//
//  priceModel.m
//  数据
//
//  Created by len on 16/5/12.
//  Copyright © 2016年 len. All rights reserved.
//

#import "priceModel.h"

@implementation priceModel
-(instancetype)initWithDict:(NSDictionary *)dic
{
    
    if ( self = [super init])
    {
        self.Iid = dic[@"id"];
        self.typeID= dic[@"typeID"];
        self.type = dic[@"type"];
        self.photo = dic[@"photo"];
        self.price = dic[@"price"];
        self.orderid = dic[@"id"];

    }
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dic
{
    return [[self alloc]initWithDict:dic];
}


//序列化
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Iid forKey:@"id"];
    [aCoder encodeObject:self.typeID forKey:@"typeID"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.orderid forKey:@"id"];
 
  
    
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init])
    {
        _Iid=[aDecoder decodeObjectForKey:@"id"];
        _typeID=[aDecoder decodeObjectForKey:@"typeID"];
        _type=[aDecoder decodeObjectForKey:@"type"];
        _photo=[aDecoder decodeObjectForKey:@"photo"];
        _price= [aDecoder decodeObjectForKey:@"price"];
        _orderid=[aDecoder decodeObjectForKey:@"id"];
       
    }
    return self;
}

@end

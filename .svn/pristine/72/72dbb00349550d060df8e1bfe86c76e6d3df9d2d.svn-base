//
//  findModel.m
//  wangyi数据解析
//
//  Created by ma c on 15/10/21.
//  Copyright (c) 2015年 bjsxt. All rights reserved.
//

#import "findModel.h"

@implementation findModel

-(instancetype)initWithDict:(NSDictionary *)dic
{
   
    if ( self = [super init])
    {
        self.Iid = dic[@"id"];
        self.upid= dic[@"upid"];
        self.type = dic[@"type"];
        self.photo = dic[@"photo"];
        self.content = dic[@"content"];
    
    }
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dic
{
    return [[self alloc]initWithDict:dic];
}
@end

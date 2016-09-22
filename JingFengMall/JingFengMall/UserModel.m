//
//  userModel.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
static UserModel *userInstance = nil;
+(id)shardManager
{
    @synchronized(self)
    {
        if (userInstance == nil) {
            userInstance = [[UserModel alloc]init];
        }
    }
    return userInstance;
}
@end

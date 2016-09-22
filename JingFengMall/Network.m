//
//  Network.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "Network.h"
#import "AFNetworking.h"

@implementation Network

-(id)init
{
    if (self = [super init]) {
        self.session = [AFHTTPSessionManager manager];
    }
    return self;
}

-(NSURLSessionDataTask*)accessNetUrl:(NSString*)url parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success 
{
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [_session POST:urlString parameters:parameters success:success failure:^(NSURLSessionDataTask *task, NSError *error){
        
    }];
}

-(NSURLSessionDataTask*)accessNetUrl:(NSString*)url parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failed:(void(^)(NSURLSessionDataTask *task, id responseObject))failed
{
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    return [_session POST:urlString parameters:parameters success:success failure:failed];


}


@end
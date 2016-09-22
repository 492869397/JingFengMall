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
    _session.requestSerializer.timeoutInterval = 5;
    return [_session POST:urlString parameters:parameters success:success failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"%@",error);
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误,请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
    }];
}


@end

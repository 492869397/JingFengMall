//
//  Network.h
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Network : NSObject

@property(strong,nonatomic)AFHTTPSessionManager *session;

-(NSString*)accessNetUrl:(NSString*)url parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success;

-(NSURLSessionDataTask*)accessNetUrl:(NSString*)url parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failed:(void(^)(NSURLSessionDataTask *task, id responseObject))failed;


@end

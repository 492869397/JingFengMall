//
//  findModel.h
//  wangyi数据解析
//
//  Created by ma c on 15/10/21.
//  Copyright (c) 2015年 bjsxt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface findModel : NSObject

@property (nonatomic ,copy)NSNumber *Iid;
@property (nonatomic ,copy)NSString *upid;
@property (nonatomic ,copy)NSString *type;
@property (nonatomic ,copy)NSString *photo;
@property (nonatomic ,copy)NSString *content;

-(instancetype)initWithDict:(NSDictionary *)dic;
+(instancetype)initWithDict:(NSDictionary *)dic;
@end

//
//  OrderModel.h
//  JingFengMall
//
//  Created by len on 16/2/15.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property(assign,nonatomic)NSInteger orderId;
@property(copy,nonatomic)NSString *startPosition;
@property(assign,nonatomic)double startLat;
@property(assign,nonatomic)double startLng;
@property(copy,nonatomic)NSString *endPosition;
@property(assign,nonatomic)double endLat;
@property(assign,nonatomic)double endLng;
@property(copy,nonatomic)NSString *orderUserPhone;
@property(copy,nonatomic)NSString *receiveUserPhone;
@property(copy,nonatomic)NSString *completeState;
@property(copy,nonatomic)NSDate *createTime;
@property(copy,nonatomic)NSDate *completeTime;

-(id)initWithStartPosition:(NSString*)startPosition endPosition:(NSString*)endPosition orderUserPhone:(NSString*)orderUserPhone receiveUserPhone:(NSString*)receiveUserPhone createTime:(NSDate*)createTime completeState:(NSString*)completeState completeTime:(NSDate*)completeTime orderId:(NSInteger)orderId startLat:(NSNumber*)startLat startLng:(NSNumber*)startLng endLat:(NSNumber*)endLat endLng:(NSNumber*)endLng;

@end

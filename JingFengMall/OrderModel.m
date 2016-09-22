//
//  OrderModel.m
//  JingFengMall
//
//  Created by len on 16/2/15.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

-(id)initWithStartPosition:(NSString*)startPosition endPosition:(NSString*)endPosition orderUserPhone:(NSString*)orderUserPhone receiveUserPhone:(NSString*)receiveUserPhone createTime:(NSDate*)createTime completeState:(NSString*)completeState completeTime:(NSDate*)completeTime orderId:(NSInteger)orderId startLat:(NSNumber *)startLat startLng:(NSNumber *)startLng endLat:(NSNumber *)endLat endLng:(NSNumber *)endLng
{
    if (self = [super init]) {
        self.startPosition = startPosition;
        self.endPosition = endPosition;
        self.orderUserPhone = orderUserPhone;
        self.createTime =createTime;
        self.completeState = completeState;
        self.receiveUserPhone = receiveUserPhone;
        self.completeTime = completeTime;
        self.orderId = orderId;
        self.startLat = startLat.doubleValue;
        self.startLng = startLng.doubleValue;
        self.endLat = endLat.doubleValue;
        self.endLng = endLng.doubleValue;
    }
    return self;
}

@end

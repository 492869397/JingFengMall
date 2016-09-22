//
//  CouponModel.m
//  JingFengMall
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

-(id)initWithCouponID:(NSNumber*)couponID couponType:(NSString*)couponType state:(NSString*)state startDate:(NSNumber*)startDate endDate:(NSNumber*)endDate
{
    if (self = [super init]) {
        
        self.couponID = couponID;
        self.couponType = couponType;
        self.startDate = startDate.doubleValue/1000;
        self.endDate = endDate.doubleValue/1000;
        self.state = state;
    }
    
    return self;
    
}

+(id)couponWithCoupon:(CouponModel*)coupon
{
    CouponModel *cou = [[CouponModel alloc]init];
    
    cou.couponID = coupon.couponID;
    cou.couponType = coupon.couponType;
    cou.startDate = coupon.startDate;
    cou.endDate = coupon.endDate;
    cou.state = coupon.state;
    
    return cou;
}

@end

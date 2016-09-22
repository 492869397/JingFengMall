//
//  CouponModel.h
//  JingFengMall
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject

@property(strong,nonatomic)NSNumber *couponID;
@property(copy,nonatomic)NSString *couponType;
@property(copy,nonatomic)NSString *state;
@property(assign,nonatomic)NSTimeInterval startDate;
@property(assign,nonatomic)NSTimeInterval endDate;


-(id)initWithCouponID:(NSNumber*)couponID couponType:(NSString*)couponType state:(NSString*)state startDate:(NSNumber*)startDate endDate:(NSNumber*)endDate;

+(id)couponWithCoupon:(CouponModel*)coupon;

@end

//
//  MallOrderModel.h
//  JingFengMall
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallOrderModel : NSObject


@property(strong,nonatomic)NSNumber *commodityid;

@property(copy,nonatomic)NSString *commodityNumber;

@property(copy,nonatomic)NSString *completeState;

@property(copy,nonatomic)NSString *paymentState;

@property(copy,nonatomic)NSString *paymentMethod;

@property(copy,nonatomic)NSString *userName;

@property(copy,nonatomic)NSString *orderMoney;

@property(copy,nonatomic)NSString *userAddressID ;

@property(copy,nonatomic)NSString *consignorPhone ;//配送人



@property(strong,nonatomic)NSMutableArray *goodsArray;


-(id)initWithCommodityid:(NSNumber*)commodityid commodityNumber:(NSString*)commodityNumber paymentState:(NSString*)paymentState paymentMethod:(NSString*)paymentMethod userName:(NSString*)userName orderMoney:(NSString*)orderMoney completeState:(NSString*)completeState consignorPhone:(NSString*)consignorPhone userAddressID:(NSString*)userAddressID;

@end

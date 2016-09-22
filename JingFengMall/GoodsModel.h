//
//  GoodsModel.h
//  JingFengMall
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property(strong,nonatomic)NSNumber *goodsID;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *c_describe;
@property(copy,nonatomic)NSString *photo;
@property(copy,nonatomic)NSString *price;
@property(copy,nonatomic)NSString *originalPrice;
@property(copy,nonatomic)NSString *buyCount;
@property(copy,nonatomic)NSString *discount;//折扣
@property(copy,nonatomic)NSString *praiseCount;//好评率
@property(copy,nonatomic)NSString *upFrame;//是否上架
@property(strong,nonatomic)NSNumber *createTime;

@property(strong,nonatomic)NSNumber *goodsNumber;

-(id)initWhthID:(NSNumber*)ID Title:(NSString *)title describe:(NSString *)describe photo:(NSString *)photo price:(NSString *)price originalPrice:(NSString *)originalPrice buyCount:(NSString *)buyCount discount:(NSString *)discount praiseCount:(NSString *)praiseCount upFrame:(NSString*)upFrame createTime:(NSNumber*)createTime;

@end

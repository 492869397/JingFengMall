//
//  ConsigneeModel.h
//  JingFengMall
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsigneeModel : NSObject

@property(strong,nonatomic)NSNumber *Id;

@property(copy,nonatomic)NSString *consignee;

@property(copy,nonatomic)NSString *userPhone;

@property(copy,nonatomic)NSString *localtion;

@property(copy,nonatomic)NSString *street;

@property(copy,nonatomic)NSString *detailAddress;

@property(copy,nonatomic)NSString *addressID;

-(id)initWithId:(NSNumber*)Id consignee:(NSString*)consignee userPhone:(NSString*)userPhone localtion:(NSString*)localtion street:(NSString*)street detailAddress:(NSString*)detailAddress addressID:(NSString*)addressID;

@end

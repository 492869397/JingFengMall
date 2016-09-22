//
//  ConsigneeModel.m
//  JingFengMall
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ConsigneeModel.h"

@implementation ConsigneeModel

-(id)initWithId:(NSNumber*)Id consignee:(NSString*)consignee userPhone:(NSString*)userPhone localtion:(NSString*)localtion street:(NSString *)street detailAddress:(NSString *)detailAddress addressID:(NSString*)addressID
{
    self = [super init];
    if (self) {
        self.Id = Id;
        self.consignee = consignee;
        self.userPhone = userPhone;
        self.localtion = localtion;
        self.street = street;
        self.detailAddress = detailAddress;
        self.addressID = addressID;
        
    }
    return self;
}

@end

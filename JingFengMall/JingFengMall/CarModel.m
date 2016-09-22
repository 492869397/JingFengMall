//
//  CarModel.m
//  JingFengMall
//
//  Created by len on 16/1/29.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

-(id)initWithPhone:(NSString*)phoneNumber carType:(NSString*)type carBrand:(NSString*)brand carNumber:(NSString*)carNumber carColor:(NSString*)color location:(CLLocationCoordinate2D)location Position:(NSString*)position
{
    if (self = [super init]) {
        self.phoneNumber = phoneNumber;
        self.carType = type;
        self.carBrand = brand;
        self.carNumber = carNumber;
        self.carColor = color;
        self.location = location;
        self.position = position;
    }
    return self;
}

@end

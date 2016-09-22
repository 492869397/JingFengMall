//
//  CarAnnotation.h
//  JingFengMall
//
//  Created by len on 16/1/21.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface CarAnnotation : BMKAnnotationView

@property(strong,nonatomic)UIImageView *customImage;
@property(strong,nonatomic)UIImage *carPic;

@end

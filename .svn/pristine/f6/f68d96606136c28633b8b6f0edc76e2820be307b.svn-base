//
//  CarAnnotation.m
//  JingFengMall
//
//  Created by len on 16/1/21.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "CarAnnotation.h"

@implementation CarAnnotation

-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bounds = CGRectMake(0.f, 0.f, 50.f, 50.f);
        self.customImage = [[UIImageView alloc]initWithFrame:self.bounds];
        self.customImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_customImage];
    }
    return self;
}

-(void)setCarPic:(UIImage *)carPic
{
    _carPic = carPic;
    self.customImage.image = _carPic;
}

@end

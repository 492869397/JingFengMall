//
//  NearByDiversViewController.m
//  JingFengMall
//
//  Created by len on 16/1/26.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "NearByDiversViewController.h"


@interface NearByDiversViewController ()

@end

@implementation NearByDiversViewController

-(void)awakeFromNib
{
    self.subView.layer.borderWidth = 1;
    self.subView.layer.cornerRadius = 5;
    self.carBrand.layer.borderWidth = 1;
    self.carBrand.layer.cornerRadius = 3;
}

-(void)setContent
{
    self.carBrand.text = self.carMassage.carBrand;
    self.carNumber.text = self.carMassage.carNumber;
    self.color.text = self.carMassage.carColor;
    self.position.text = self.carMassage.position;
}

- (IBAction)callPhone:(id)sender {

    NSString *phoneNumber = self.carMassage.phoneNumber;
    
    NSString *phone = [NSString stringWithFormat:@"tel://%@",phoneNumber];
    NSURL *url = [NSURL URLWithString:phone];
    [[UIApplication sharedApplication] openURL:url];
}

@end

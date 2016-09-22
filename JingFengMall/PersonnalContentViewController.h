//
//  PersonnalContentViewController.h
//  JingFengMall
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonnalContentViewController : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *userName;
@property(weak,nonatomic)id delegate;
@property (strong, nonatomic) IBOutlet UIView *account;
@property (strong, nonatomic) IBOutlet UIImageView *touxiang;
@property (strong, nonatomic) IBOutlet UILabel *couponCount;
@property (strong, nonatomic) IBOutlet UILabel *cardPrice;
@property (strong, nonatomic) IBOutlet UIImageView *VIPGrade;

@property(strong,nonatomic)NSNumber *JingFengCoin;


- (IBAction)enterDistributionView:(id)sender;
- (IBAction)enterCouponView:(id)sender;

- (IBAction)recharge:(id)sender;

- (IBAction)enterVIPView:(id)sender;

- (IBAction)enterOrderView:(id)sender;
- (IBAction)enterReturnView:(id)sender;

@end

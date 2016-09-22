//
//  DistributionViewController.h
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DistributionViewController : UIViewController


//返利数组
@property(strong,nonatomic)NSArray *subArray;
//邀请数组
@property(strong,nonatomic)NSArray *inviteArray;
//下级消费数组
@property(strong,nonatomic)NSArray *payArray;

@property (strong, nonatomic) IBOutlet UILabel *totalMoney;
@property (strong, nonatomic) IBOutlet UILabel *inviteNumber;
@property (strong, nonatomic) IBOutlet UILabel *payNumber;
@property (strong, nonatomic) IBOutlet UILabel *plusMoney;
@property (strong, nonatomic) IBOutlet UILabel *freezeMoney;


- (IBAction)inviteOther:(id)sender;

@end

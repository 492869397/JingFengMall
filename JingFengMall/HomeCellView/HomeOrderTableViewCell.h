//
//  HomeOrderTableViewCell.h
//  JingFengMall
//
//  Created by len on 16/5/7.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeOrderModel.h"

@interface HomeOrderTableViewCell : UITableViewCell

@property(weak,nonatomic)UIViewController *delegate;

@property (strong,nonatomic)HomeOrderModel *model;
@property (strong, nonatomic) IBOutlet UIButton *FinishBtn;
@property (strong, nonatomic) IBOutlet UIButton *LinkManBtn;
@property (strong, nonatomic) IBOutlet UIButton *PingJiaBtn;
@property (nonatomic,copy)NSString *strID;
@property (nonatomic,copy)NSString *strorderID;
@property (nonatomic,copy)NSString *employeeID;

@property (copy,nonatomic)NSString *module;
@property (nonatomic,copy)NSString *typeId;

@property (strong, nonatomic) IBOutlet UIButton *FinishingBtn;
@property (strong, nonatomic) IBOutlet UIButton *LookUpBtn;

@property (strong, nonatomic) IBOutlet UILabel *Servicelbl;


@end
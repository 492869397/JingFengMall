//
//  PersonnalCenterViewController.h
//  JingFengMall
//
//  Created by len on 16/3/8.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "PersonnalContentViewController.h"
#import "BaseRootViewController.h"

@interface PersonnalCenterViewController : BaseRootViewController

@property(strong,nonatomic)UIScrollView *scroll;
@property(strong,nonatomic)PersonnalContentViewController *contentView;

@end

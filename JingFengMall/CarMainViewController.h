//
//  CarMainViewController.h
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "LoginViewController.h"
#import "YYCycleScrollView.h"

@interface CarMainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *scroll;


- (IBAction)getCar:(id)sender;
- (IBAction)carOwner:(id)sender;
- (IBAction)enterHistory:(id)sender;


@end

//
//  RechargeView.h
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface RechargeView : UIView

@property(assign,nonatomic)UIViewController *delegate;

@property(strong,nonatomic)MBProgressHUD *HUD;

@property (strong, nonatomic) IBOutlet UITextField *price;

- (IBAction)weixinPay:(id)sender;

- (IBAction)aliPay:(id)sender;

@end
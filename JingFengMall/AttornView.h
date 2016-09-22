//
//  AttornView.h
//  JingFengMall
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttornView : UIView

@property(weak,nonatomic)UIViewController *delegate;

@property (strong, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UIView *subview;
@property (weak, nonatomic) IBOutlet UITextField *coin;
@property(strong,nonatomic)NSNumber *maxCoin;

@end

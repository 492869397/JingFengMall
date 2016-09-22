//
//  SelectBillViewController.h
//  JingFengMall
//
//  Created by mac on 16/4/9.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBillViewController : UIViewController

@property(assign,nonatomic)id delegate;

@property (strong, nonatomic) IBOutlet UITextField *bill;

@end

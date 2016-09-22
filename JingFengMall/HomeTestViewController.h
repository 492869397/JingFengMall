//
//  HomeTestViewController.h
//  JingFengMall
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "YYCycleScrollView.h"

@interface HomeTestViewController : UIViewController

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mallBigWith;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mallBigHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mallSmallHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *storeBigWith;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *storeBigHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *foodHeight;

@property(weak,nonatomic)UIViewController *delegate;

@property(assign,nonatomic)BOOL freshComplate;

@property (strong, nonatomic) IBOutlet UIView *scroll;
@property (strong, nonatomic) IBOutlet UIView *scroll1;
@property (strong, nonatomic) IBOutlet UIView *scroll3;
@property (strong, nonatomic) IBOutlet UIView *scroll2;


@property (strong, nonatomic) YYCycleScrollView *adscroll1;
@property (strong, nonatomic) YYCycleScrollView *adscroll2;
@property (strong, nonatomic) YYCycleScrollView *adscroll3;

- (IBAction)selectByTag:(id)sender;

-(void)fresh;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonHeight;


@end
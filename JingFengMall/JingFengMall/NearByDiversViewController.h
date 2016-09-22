//
//  NearByDiversViewController.h
//  JingFengMall
//
//  Created by len on 16/1/26.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "CarModel.h"

@interface NearByDiversViewController : UITableViewCell

@property(strong,nonatomic)CarModel *carMassage;
@property(strong,nonatomic)UIViewController *delegate;
@property(assign,nonatomic)NSInteger index;

@property (strong, nonatomic) IBOutlet UIView *subView;
@property (strong, nonatomic) IBOutlet UILabel *carBrand;
@property (strong, nonatomic) IBOutlet UILabel *color;
@property (strong, nonatomic) IBOutlet UILabel *carNumber;
@property (strong, nonatomic) IBOutlet UILabel *position;

- (IBAction)callPhone:(id)sender;
//- (IBAction)lookPosition:(id)sender;

-(void)setContent;

@end

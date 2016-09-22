//
//  CommitOrderViewController.h
//  JingFengMall
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ConsigneeModel.h"

@interface CommitOrderViewController : UIViewController

@property (strong, nonatomic)ConsigneeModel *con;

@property(copy,nonatomic)NSString *bill;

@property(strong,nonatomic)NSMutableArray *array;

@property(assign,nonatomic)double totalPrice;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UILabel *minusMoney;

@property (weak, nonatomic) IBOutlet UILabel *canUseMoney;

@property (strong, nonatomic) IBOutlet UIImageView *photo;

@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *minusPrice;
@property (strong, nonatomic) IBOutlet UILabel *finalPrice;


- (IBAction)lookGoodsDetail:(id)sender;
- (IBAction)selectGetGoodsPlace:(UITapGestureRecognizer *)sender;
- (IBAction)selectBill:(UITapGestureRecognizer *)sender;


- (IBAction)confirm:(UIButton *)sender;

-(void)calculatePrice;

@end

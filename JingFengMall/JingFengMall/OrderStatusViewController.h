//
//  OrderStatusViewController.h
//  JingFengMall
//
//  Created by len on 16/1/26.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "OrderModel.h"

@interface OrderStatusViewController : UITableViewCell

@property(strong,nonatomic)OrderModel *order;

@property(weak,nonatomic)id delegate;
@property (strong, nonatomic) IBOutlet UILabel *startPosition;
@property (strong, nonatomic) IBOutlet UILabel *endPosition;
@property (strong, nonatomic) IBOutlet UILabel *orderStatus;
@property (strong, nonatomic) IBOutlet UILabel *createTime;
@property (strong, nonatomic) IBOutlet UILabel *carBrand;

- (IBAction)lookPosition:(id)sender;
- (IBAction)cancelOrder:(id)sender;
- (IBAction)callDiver:(id)sender;

-(void)setContent;
@end

//
//  OnlyOrderViewController.h
//  JingFengMall
//
//  Created by len on 16/1/26.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "OrderModel.h"

@interface OnlyOrderViewController : UITableViewCell

@property(strong,nonatomic)OrderModel *order;
@property(weak,nonatomic)id delegate;
@property (strong, nonatomic) IBOutlet UILabel *startPosition;
@property (strong, nonatomic) IBOutlet UILabel *endPosition;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UILabel *staus;
- (IBAction)detailView:(id)sender;
- (IBAction)callPhone:(id)sender;
- (IBAction)getOrder:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *getOrder;

-(void)setContent;

@end

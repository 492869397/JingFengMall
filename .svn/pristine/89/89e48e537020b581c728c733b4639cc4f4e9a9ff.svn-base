//
//  CartTableViewCell.h
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartTableViewController.h"
#import "GoodsModel.h"

@interface CartTableViewCell : UITableViewCell

@property(assign,nonatomic)CartTableViewController *delegate;

@property(strong,nonatomic)GoodsModel *goods;

@property(assign,nonatomic)BOOL checked;

@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) IBOutlet UIButton *selectButton;

- (IBAction)minus:(id)sender;

- (IBAction)plus:(id)sender;

- (IBAction)beSelected:(id)sender;

@end

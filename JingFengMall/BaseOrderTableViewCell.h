//
//  BaseOrderTableViewCell.h
//  JingFengMall
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallOrderModel.h"
#import "CellSubview.h"

@interface BaseOrderTableViewCell : UITableViewCell

@property(assign,nonatomic)UIViewController *delegate;

@property(strong,nonatomic)MallOrderModel *order;


@end

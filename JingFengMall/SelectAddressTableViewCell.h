//
//  SelectAddressTableViewCell.h
//  JingFengMall
//
//  Created by mac on 16/4/9.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsigneeModel.h"

@interface SelectAddressTableViewCell : UITableViewCell

@property(assign,nonatomic)id delegate;

@property (strong, nonatomic)ConsigneeModel *con;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *address;

@end

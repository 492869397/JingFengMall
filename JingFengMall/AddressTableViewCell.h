//
//  AddressTableViewCell.h
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ConsigneeModel.h"

@interface AddressTableViewCell : UITableViewCell

@property(assign,nonatomic)id delegate;

@property(strong,nonatomic)ConsigneeModel *con;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *address;


- (IBAction)edit:(id)sender;
- (IBAction)deleteReciver:(id)sender;


@end

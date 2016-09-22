//
//  SubDetailTableViewCell.h
//  JingFengMall
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *subview;

@property (strong, nonatomic) IBOutlet UILabel *phone;

@property (strong, nonatomic) IBOutlet UILabel *date;

@property (strong, nonatomic) IBOutlet UILabel *money;

@property (strong, nonatomic) IBOutlet UIImageView *photo;

@end

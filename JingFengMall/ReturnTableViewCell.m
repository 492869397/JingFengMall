//
//  ReturnTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ReturnTableViewCell.h"
#import "ReturnGoodsViewController.h"

@implementation ReturnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)returnGoods:(id)sender {
    
    ReturnGoodsViewController *goods = [[ReturnGoodsViewController alloc]init];
    goods.commodityid = [NSString stringWithFormat:@"%@",self.order.commodityid];
    [((UIViewController*)self.delegate).navigationController pushViewController:goods animated:YES];
    
}

@end

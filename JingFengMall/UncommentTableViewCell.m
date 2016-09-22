//
//  UncommentTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "UncommentTableViewCell.h"
#import "CommentGoodsViewController.h"

@implementation UncommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)commentGoods:(id)sender {
    
    CommentGoodsViewController *comment = [[CommentGoodsViewController alloc]init];
    
    comment.order = self.order;
    
    [self.delegate.navigationController pushViewController:comment animated:YES];
    
}
@end

//
//  CommentServicerTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CommentServicerTableViewCell.h"
#import "CommentService.h"

@implementation CommentServicerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)commentService:(id)sender {
    
    CommentService *view = [[[NSBundle mainBundle]loadNibNamed:@"CommentService" owner:nil options:nil]firstObject];
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
}
- (IBAction)lookService:(id)sender {
}

@end

//
//  UnsendTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "UnsendTableViewCell.h"
#import "HintView.h"

@implementation UnsendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)remindSendGoods:(id)sender {
    
    [self performSelector:@selector(DisplayHintView) withObject:nil afterDelay:0.8];
    
}

-(void)DisplayHintView
{
    HintView *view = [[[NSBundle mainBundle]loadNibNamed:@"HintView" owner:nil options:nil]firstObject];
    
    view.msg.text = @"你的提醒消息已发送给卖家";
    
    view.frame = CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT);
    
    [[[UIApplication sharedApplication] keyWindow]addSubview:view];
}

@end

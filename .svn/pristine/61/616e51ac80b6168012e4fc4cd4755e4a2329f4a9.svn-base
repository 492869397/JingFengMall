//
//  HomeSecondViewCell.m
//  JingFengMall
//
//  Created by len on 16/5/6.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeSecondViewCell.h"
#import "UIImageView+WebCache.h"

@interface HomeSecondViewCell ()


@property (strong, nonatomic) IBOutlet UILabel *Bigtitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (strong, nonatomic) IBOutlet UILabel *Smalltitle;

@end
@implementation HomeSecondViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
    
}

-(void)setZero{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        self.layoutMargins=UIEdgeInsetsZero;
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        self.separatorInset=UIEdgeInsetsZero;
    }
}

-(void)setModel:(findModel *)model
{
    [self.Bigtitle setText:model.type];
    [self.Smalltitle setText:model.content];
    NSURL *url = [NSURL URLWithString:model.photo];
    [self.imageview  sd_setImageWithURL:url];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

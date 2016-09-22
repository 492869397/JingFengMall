//
//  CartTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

- (void)awakeFromNib {
    
    [self.selectButton setImage:[UIImage imageNamed:@"btn5"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"btn1_no"] forState:UIControlStateSelected];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)minus:(id)sender {
    
    NSInteger num = _number.text.integerValue;
    if (num >1) {
        _number.text = [NSString stringWithFormat:@"%ld",(long)num-1];
    }
    _goods.goodsNumber = [NSNumber numberWithInteger:[_number.text integerValue]];
}

- (IBAction)plus:(id)sender {
    NSInteger num = _number.text.integerValue;
    _number.text = [NSString stringWithFormat:@"%ld",(long)num+1];
    _goods.goodsNumber = [NSNumber numberWithInteger:[_number.text integerValue]];
}

- (IBAction)beSelected:(UITapGestureRecognizer*)sender {
    if (self.selectButton.selected) {
        
        self.checked = NO;
        
    }else
    {
        self.checked = YES;
    }
    
    [self.delegate deselectedCellButtonWith:self checked:_selectButton.selected];
    
}

-(void)setChecked:(BOOL)checked
{
    self.selectButton.selected = checked;
}

@end

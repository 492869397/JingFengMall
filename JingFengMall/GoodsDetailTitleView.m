//
//  GoodsDetailTitleView.m
//  JingFengMall
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "GoodsDetailTitleView.h"

@implementation GoodsDetailTitleView

-(void)didMoveToSuperview
{
    self.separateLineHeight.constant = 0.3;
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    
//    if (self = [super initWithCoder:aDecoder]) {
//        UIView *containerView = [[[UINib nibWithNibName:@"GoodsDetailTitleView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
//        
//        containerView.translatesAutoresizingMaskIntoConstraints = NO;
//        [self addSubview:containerView];
//        
//        
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
//        
//    }
//    return self;
//    
//}


@end
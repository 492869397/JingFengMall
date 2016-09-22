//
//  YGImageView.m
//  test
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YGImageView.h"

@implementation YGImageView


-(void)tap:(UITapGestureRecognizer *)tap
{
    _block(self);
}

-(void)addTapEvent:(tapBlock)block
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    self.block = block;
    
}

@end

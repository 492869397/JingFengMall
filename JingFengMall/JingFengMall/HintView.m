//
//  HintView.m
//  JingFengMall
//
//  Created by len on 16/2/18.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "HintView.h"

@implementation HintView

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end

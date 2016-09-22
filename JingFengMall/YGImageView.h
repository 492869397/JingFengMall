//
//  YGImageView.h
//  test
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YGImageView : UIImageView

typedef void (^tapBlock)(YGImageView *);



@property(copy,nonatomic)NSString *title;

@property(copy,nonatomic)NSString *module;

@property(copy,nonatomic)NSString *type;

@property(copy,nonatomic)tapBlock block;

-(void)addTapEvent:(tapBlock)block;

@end

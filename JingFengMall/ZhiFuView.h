//
//  ZhiFuView.h
//  test
//
//  Created by mac on 16/4/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ZhiFuView : UIView

@property(strong,nonatomic)MBProgressHUD *HUD;

@property (weak, nonatomic) IBOutlet UIView *subView;

@property(assign,nonatomic)id delegate;

@property(strong,nonatomic)NSNumber *num;

@property(assign,nonatomic)int payFlag;

@end

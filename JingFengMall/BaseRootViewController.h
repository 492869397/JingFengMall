//
//  BaseRootViewController.h
//  JingFengMall
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseRootViewController : UIViewController

-(UIView*) errorView;
-(UIView*) loadingView;
-(void) showLoadingAnimated:(BOOL) animated;
-(void) hideLoadingViewAnimated:(BOOL) animated;
-(void) showErrorViewAnimated:(BOOL) animated;
-(void) hideErrorViewAnimated:(BOOL) animated;

@end

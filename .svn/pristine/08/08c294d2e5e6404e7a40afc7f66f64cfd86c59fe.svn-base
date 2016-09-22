//
//  YGNavigationController.m
//  Tabbar
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YGNavigationController.h"

@interface YGNavigationController ()

@end

@implementation YGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        
        self.navigationBarHidden = NO;
        
    }else
    {
        self.navigationBarHidden = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated;
{
    if (self.viewControllers.count <= 2) {

        self.navigationBarHidden = YES;
        
    }
    return [super popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        
        self.navigationBarHidden = YES;
        
    }
    
    return [super popToViewController:viewController animated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    
    self.navigationBarHidden = YES;
    
    return [super popToRootViewControllerAnimated:animated];
    
}

@end

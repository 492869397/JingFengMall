//
//  SearchTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "LoginViewController.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addToCart:(id)sender {
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"]) {
        
        Toast *toa = [Toast makeText:@"登录后才能进行此操作"];
        [toa showWithType:ShortTime];
        
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.delegate.navigationController pushViewController:login animated:YES];
        
        return;
    }
    
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:4];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    [pass setObject:_goods.goodsID forKey:@"commodityID"];
    [pass setObject:@"1" forKey:@"commodityNumber"];
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/addMallShoppingCart.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            Toast *toa = [Toast makeText:@"加入购物车成功"];
            [toa showWithType:ShortTime];
        }else
        {
            NSString *str = [responseObject objectForKey:@"msg"];
            Toast *toa = [Toast makeText:str];
            [toa showWithType:ShortTime];
        }
    }];
    
}

@end

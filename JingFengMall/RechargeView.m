//
//  RechargeView.m
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "RechargeView.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PayFailViewController.h"
#import "PayResultViewController.h"
#import "RDVTabBarController.h"

@implementation RechargeView


- (IBAction)aliPay:(UIButton *)sender {
    
    
    if (![self isMoneyIsNumber]) {
        return;
    }
    
    
    
    _HUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.label.text = @"Loading";
    [_HUD showAnimated:YES];
    
    
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"];
    
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:phone forKey:@"userPhone"];
    [pass setObject:_price.text forKey:@"amout"];
    [[AFHTTPSessionManager manager] POST:@"http://123.57.28.11:8080/jfsc_app/addConsumption.do" parameters:pass success:^(NSURLSessionDataTask * ta, id responseObject) {
        
        [_HUD hideAnimated:NO];

        
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
            
            [self doAliPay:[responseObject objectForKey:@"order"]];
            
        }else{
            
            Toast *toast = [Toast makeText:@"操作失败,请重试"];
            [toast showWithType:ShortTime];
        }
        
        
    } failure:^(NSURLSessionDataTask * ta, NSError * error) {
        
        [_HUD hideAnimated:NO];
        
        Toast *toast = [Toast makeText:@"网络连接失败,请重试"];
        [toast showWithType:ShortTime];
    }];
    
    
}


- (IBAction)cancel:(id)sender {
    
    [self removeFromSuperview];
    
}

-(void)doAliPay:(NSString*)string
{
    
    if (![self isMoneyIsNumber]) {
        return;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"JingFengMall";
    
    [[AlipaySDK defaultService] payOrder:string fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"%@",[[resultDic objectForKey:@"resultStatus"] class]);
        NSString *code = [resultDic objectForKey:@"resultStatus"];
        if ([code isEqualToString:@"9000"]) {
            
            PayResultViewController *view = [[PayResultViewController alloc]init];
            [[[(UIViewController*)self.delegate rdv_tabBarController] navigationController] pushViewController:view animated:YES];
            [self removeFromSuperview];
            
        }else if ([code isEqualToString:@"4000"] || [code isEqualToString:@"6002"])
        {
            
            PayFailViewController *fail = [[ PayFailViewController alloc]init];
            [[(UIViewController*)self.delegate navigationController] pushViewController:fail animated:YES];
            [self removeFromSuperview];
            
            
        }
        
        [self.delegate viewWillAppear:YES];
    }];
    
}




#pragma 微信支付

- (IBAction)weixinPay:(UIButton *)sender {
    
    
    if (![self isMoneyIsNumber]) {
        return;
    }
    
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    [activity setCenter:CGPointMake(kMainScreenWidth/2.0, kMainScreenHeight/2.0)];//指定进度轮中心点
    
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
    [self addSubview:activity];
    [activity startAnimating];
    
    
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"];
    
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:phone forKey:@"userPhone"];
    [pass setObject:_price.text forKey:@"amout"];
    
    [[AFHTTPSessionManager manager] POST:@"http://192.168.31.203:8080/jfsc_app/weixinpay.do" parameters:nil success:^(NSURLSessionDataTask * ta, id responseObject) {
        
        [self doWXPay:responseObject];
        
        [activity stopAnimating];
        [activity removeFromSuperview];
        
    } failure:^(NSURLSessionDataTask * ta, NSError * error) {
        [activity stopAnimating];
        [activity removeFromSuperview];
        
        Toast *toast = [Toast makeText:@"网络连接失败,请重试"];
        [toast showWithType:ShortTime];
    }];
    
    
}


-(void)doWXPay:(NSDictionary*)dic
{
//    PayReq *request = [[PayReq alloc]init];
//    request.partnerId = [dic objectForKey:@"partner"];
//    request.prepayId= [dic objectForKey:@"prepay_id2"];
//    request.package = [dic objectForKey:@"packages"];
//    request.nonceStr= [dic objectForKey:@"nonceStr"];
//    request.timeStamp= [(NSString*)[dic objectForKey:@"timestamp"] intValue];
//    request.sign= [dic objectForKey:@"sign"];
//    [WXApi sendReq:request];
    
    PayReq *request = [[PayReq alloc]init];
//    request.appId = [dic objectForKey:@"appid"];
    request.partnerId = [dic objectForKey:@"partnerid"];
    request.prepayId= [dic objectForKey:@"prepayid"];
    request.package = [dic objectForKey:@"package"];
    request.nonceStr= [dic objectForKey:@"noncestr"];
    request.timeStamp= [(NSString*)[dic objectForKey:@"timestamp"] intValue];
    request.sign= [dic objectForKey:@"sign"];
    [WXApi sendReq:request];
    
}



-(BOOL)isMoneyIsNumber
{
    NSString *str = _price.text;
    
    if ([self isPureInt:str] || [self isPureFloat:str]) {
        
        return YES;

    }
    
    Toast *toa = [Toast makeText:@"金额输入有误"];
    [toa showWithType:ShortTime];
    return NO;
}

//判断字符串是否是整型
- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}

@end

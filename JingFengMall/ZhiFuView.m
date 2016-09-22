//
//  ZhiFuView.m
//  test
//
//  Created by mac on 16/4/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZhiFuView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "PayFailViewController.h"
#import "PayResultViewController.h"
#import "MyOrderViewController.h"


@implementation ZhiFuView

- (void)willMoveToSuperview:(nullable UIView *)newSuperview
{
    self.subView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.subView.layer.borderWidth = 1;
    self.subView.layer.cornerRadius = 15;
}


/*
 payFlag 是用来标识支付模块接口的，
 1 商城模块，
 2 家政模块，
 */


#pragma mark - 支付宝支付

- (IBAction)aliPay:(UIButton *)sender {
    
    _HUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.label.text = @"Loading";
    [_HUD showAnimated:YES];

   
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:_num forKey:@"id"];
    
    
    NSString *url;
    
    switch (_payFlag) {
        case 1:
            url = @"http://123.57.28.11:8080/jfsc_app/aliPay.do";
            break;
            
        case 2:
            url = @"http://123.57.28.11:8080/jfsc_app/housealiPay.do";
            break;
            
        default:
            break;
    }
    
    
    [[AFHTTPSessionManager manager] POST:url parameters:pass success:^(NSURLSessionDataTask * ta, id responseObject) {
        
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


-(void)doAliPay:(NSString*)string
{
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"JingFengMall";

    [[AlipaySDK defaultService] payOrder:string fromScheme:appScheme callback:^(NSDictionary *resultDic) {

        NSString *code = [resultDic objectForKey:@"resultStatus"];
        if ([code isEqualToString:@"9000"]) {
            
            PayResultViewController *view = [[PayResultViewController alloc]init];
            [[(UIViewController*)self.delegate navigationController] pushViewController:view animated:YES];
            [self removeFromSuperview];
            
            if ([self.delegate isKindOfClass:[MyOrderViewController class]]) {
                [(MyOrderViewController*)self.delegate getData];
            }
            
        }else if ([code isEqualToString:@"4000"] || [code isEqualToString:@"6002"])
        {
            
            PayFailViewController *fail = [[ PayFailViewController alloc]init];
            [[(UIViewController*)self.delegate navigationController] pushViewController:fail animated:YES];
            [self removeFromSuperview];
            
            if ([self.delegate isKindOfClass:[MyOrderViewController class]]) {
                [(MyOrderViewController*)self.delegate getData];
            }
            
        }
        
    }];

}




#pragma mark - 微信支付

- (IBAction)wxPay:(UIButton *)sender {
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    [activity setCenter:CGPointMake(kMainScreenWidth/2.0, kMainScreenHeight/2.0)];//指定进度轮中心点
    
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
    [self addSubview:activity];
    [activity startAnimating];
    
    
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    
    [pass setObject:_num forKey:@"id"];
    
    NSString *url;
    
    switch (_payFlag) {
        case 1:
            url = @"http://123.57.28.11:8080/jfsc_app/weixinaliPay.do";
            break;
            
        case 2:
            url = @"http://123.57.28.11:8080/jfsc_app/houseweixinaliPay.do";
            break;
            
        default:
            break;
    }
    
    
    
    [[AFHTTPSessionManager manager] POST:url parameters:pass success:^(NSURLSessionDataTask * ta, id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
            
            [self doWXPay:[responseObject objectForKey:@"order"]];
            
        }
        
        [activity stopAnimating];
        [activity removeFromSuperview];
        
    } failure:^(NSURLSessionDataTask * ta, NSError * error) {
        [activity stopAnimating];
        [activity removeFromSuperview];
        
        Toast *toast = [Toast makeText:@"网络连接失败,请重试"];
        [toast showWithType:ShortTime];
    }];
    
}


-(void)doWXPay:(NSString*)para
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXPayComplate) name:@"WXPayComplate" object:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[para dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    PayReq *request = [[PayReq alloc]init];
    request.partnerId = [dic objectForKey:@"partnerid"];
    request.prepayId= [dic objectForKey:@"prepayid"];
    request.package = [dic objectForKey:@"package"];
    request.nonceStr= [dic objectForKey:@"noncestr"];
    request.timeStamp= [(NSString*)[dic objectForKey:@"timestamp"] intValue];
    request.sign= [dic objectForKey:@"sign"];
    [WXApi sendReq:request];
    
    
}

-(void)WXPayComplate
{
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXPayComplate" object:nil];
}


#pragma mark - 储值卡支付
- (IBAction)CardPay:(id)sender {
    
    
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    
    [pass setObject:_num forKey:@"id"];
    
    NSString *strURL;
    switch (_payFlag) {
        case 1:
            strURL = @"http://123.57.28.11:8080/jfsc_app/memberCardPay.do";
            break;
            
        case 2:
            strURL = @"http://123.57.28.11:8080/jfsc_app/memberCardPayByHouse.do";
            break;
            
        default:
            break;
    }

    
    _HUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.label.text = @"Loading";
    [_HUD showAnimated:YES];

    
    AFHTTPRequestOperationManager *mgr2=[AFHTTPRequestOperationManager manager];
    [mgr2 POST:strURL parameters:pass  success:^(AFHTTPRequestOperation * operation, id responsObject)
 {
     [_HUD hideAnimated:NO];
     
     if ([[responsObject objectForKey:@"code"]isEqualToNumber:@1]) {
         
         PayResultViewController *view = [[PayResultViewController alloc]init];
         [[(UIViewController*)self.delegate navigationController] pushViewController:view animated:YES];
         [self removeFromSuperview];
         
         if ([self.delegate isKindOfClass:[MyOrderViewController class]]) {
             [(MyOrderViewController*)self.delegate getData];
         }
         
     }else
     {
         
         PayFailViewController *fail = [[ PayFailViewController alloc]init];
         [[(UIViewController*)self.delegate navigationController] pushViewController:fail animated:YES];
         [self removeFromSuperview];
         
         Toast *toa = [Toast makeText:responsObject[@"msg"]];
         [toa showWithType:ShortTime];
         
         if ([self.delegate isKindOfClass:[MyOrderViewController class]]) {
             [(MyOrderViewController*)self.delegate getData];
         }
         
     }
     
}failure:^(AFHTTPRequestOperation * operation, NSError * error)
     {
         [_HUD hideAnimated:NO];
     }
     
     ];
    
}


- (IBAction)cancel:(id)sender {
    
    [self removeFromSuperview];
    
}

@end
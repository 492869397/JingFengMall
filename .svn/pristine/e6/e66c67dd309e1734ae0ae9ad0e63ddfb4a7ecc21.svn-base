//
//  DistributionViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

#import "DistributionViewController.h"
#import "WhatsDistributionViewController.h"
#import "SubDetailViewController.h"


@interface DistributionViewController ()

@end

@implementation DistributionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIEdgeInsets edge = UIEdgeInsetsMake(12, 12, 12, 12);
    UIImage *backgroundImage = [[UIImage imageNamed:@"btn"]resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    UIButton *button = [self.view viewWithTag:100];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
    
//    self.subArray = [NSArray array];
//    self.inviteArray = [NSArray array];
//    self.payArray = [NSArray array];
//    
    [self fresh];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [super viewWillDisappear:animated];
    
}


-(void)fresh
{
    Network *net = [[Network alloc]init];
    
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"];
    
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:1];
    [pass setObject:phone forKey:@"userPhone"];
    
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/distributorInfo.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            self.subArray = [NSArray arrayWithArray:[responseObject objectForKey:@"listCommission"]];
            
            self.inviteArray = [NSArray arrayWithArray:[responseObject objectForKey:@"subUser"]];
            
            self.payArray = [NSArray arrayWithArray:[responseObject objectForKey:@"subUserSpending"]];
            
            
            _totalMoney.text = [NSString stringWithFormat:@"%.2f元",[(NSNumber*)[responseObject objectForKey:@"total"] doubleValue]];
            
            _freezeMoney.text = [NSString stringWithFormat:@"%.2f元被冻结",[[responseObject objectForKey:@"freeze"]doubleValue]];
            
            double plus = [(NSNumber*)[responseObject objectForKey:@"total"] doubleValue] + [(NSNumber*)[responseObject objectForKey:@"freeze"] doubleValue];
            
            _plusMoney.text = [NSString stringWithFormat:@"%.2f",plus];
            
            _inviteNumber.text = [NSString stringWithFormat:@"%ld",(long)_inviteArray.count];
            
            _payNumber.text = [NSString stringWithFormat:@"%ld",(long)_payArray.count];
            
        }else
        {
            NSString * msg = [responseObject objectForKey:@"msg"];
            Toast *toa = [Toast makeText:msg];
            [toa showWithType:ShortTime];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)inviteOther:(id)sender {
    
    NSString *userPhone = [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"];
    
    NSInteger a = userPhone.integerValue * 3 ;

    
    NSString *user = [NSString stringWithFormat:@"%ld",(long)a];
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"img_car1"]];

    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.28.11:8080/jfsc_app/share.jsp?userPhone=%@" ,user]]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
 
  
        
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:self.view
                                 items:@[@(SSDKPlatformTypeSinaWeibo),
                                         @(SSDKPlatformSubTypeWechatSession),
                                         @(SSDKPlatformSubTypeWechatTimeline),
                                         @(SSDKPlatformSubTypeQQFriend),
                                         @(SSDKPlatformSubTypeQZone)]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                       
                       
                   }
         ];}
    
    
    
}

- (IBAction)enterWhatsDistribution:(id)sender {
    
    WhatsDistributionViewController *what = [[WhatsDistributionViewController alloc]init];
    
    [self.navigationController pushViewController:what animated:YES];
}

- (IBAction)enterSubDetail:(id)sender {
    
    SubDetailViewController *sub = [[SubDetailViewController alloc]init];
    
    sub.cellType = SubCellHaveMoneyLabel;
    
    sub.array = _subArray;
    
    [self.navigationController pushViewController:sub animated:YES];
    
}

- (IBAction)lookInvitePeople:(id)sender {
    
    SubDetailViewController *sub = [[SubDetailViewController alloc]init];
    
    sub.cellType = SubCellNoMoneyLabel;
    
    sub.array = _inviteArray;
    
    [self.navigationController pushViewController:sub animated:YES];
    
}

- (IBAction)lookPayPeople:(id)sender {
    
    SubDetailViewController *sub = [[SubDetailViewController alloc]init];
    
    sub.cellType = SubCellNoMoneyLabel;
    
    sub.array = _payArray;
    
    [self.navigationController pushViewController:sub animated:YES];
}
@end

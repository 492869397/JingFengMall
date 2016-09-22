//
//  AppDelegate.m
//  JingFengMall
//
//  Created by len on 16/1/20.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "AppDelegate.h"
#import "CarMainViewController.h"
#import "UIView+YSTextInputKeyboard.h"
#import "HintView.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <AlipaySDK/AlipaySDK.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"



#import "RDVTabBarItem.h"
#import "RDVTabBarController.h"
#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "PersonnalCenterViewController.h"
#import "CartTableViewController.h"
#import "MarketViewController.h"
#import "FoodsViewController.h"

#import "PayResultViewController.h"
#import "PayFailViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    //统一设置导航栏颜色
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:[UIColor redColor]];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -70) forBarMetrics:UIBarMetricsDefault];
    
    [self setupViewControllers];
    [self initManager];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupViewControllers {
    
    HomeViewController *viewc = [[HomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewc];
    
    MarketViewController *market = [[MarketViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:market];
    
    FoodsViewController *foods = [[FoodsViewController alloc]init];
    UINavigationController *nav2 = [[UINavigationController  alloc]initWithRootViewController:foods];
    
    CartTableViewController *cart = [[CartTableViewController alloc]init];
    UINavigationController *nav3 = [[UINavigationController  alloc]initWithRootViewController:cart];
    
    CategoryViewController *cateView = [[CategoryViewController alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:cateView];
    
    PersonnalCenterViewController *person = [[PersonnalCenterViewController alloc]init];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:person];
    
    
    RDVTabBarController *tab = [[RDVTabBarController alloc]init];
    [tab setViewControllers:@[nav,nav1,nav2,nav3,nav4,nav5]];
    
    [self customizeTabBarForController:tab];
    
    
    _navigation = [[YGNavigationController alloc]initWithRootViewController:tab];
    
    
    self.window.rootViewController = _navigation;
    
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    
    
    
    NSArray *tabBarItemImages = @[@"tab0", @"tab1", @"tab2",@"tab3", @"tab4", @"tab5"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {

        UIImage *finishedImage = [self imageWithColor:[UIColor blackColor] size:CGSizeMake(100, 44)];
        UIImage *unfinishedImage = [self imageWithColor:[UIColor blackColor] size:CGSizeMake(100, 44)];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@-1",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        
        index++;
    }
    

}

-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

//初始化一些操作
-(void)initManager
{
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUserLogin"];
    [self loginUser];
    
    //获得服务器发送的订单被接受的消息时做出应答
    [self initGetOrderMassge];
    // 键盘自动管理
    [YSKeyboardMoving appearance].offset = 10;
    //地图管理器
    self.mapManager = [[BMKMapManager alloc]init];
    [self baiduMapPermisson];

    //定位管理器
    self.locationManager = [[BMKLocationService alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 10;
    self.locationManager.headingFilter = 5;
    [self.locationManager startUserLocationService];
    
    self.geosearch = [[BMKGeoCodeSearch alloc]init];
    self.geosearch.delegate = self;
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUnfinishedOrder"]) {
        self.orderTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(isSelfOrderRecivedFromNet) userInfo:nil repeats:YES];
    }
}

// 百度地图鉴权及社会化分享sdk初始化
-(void)baiduMapPermisson
{
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    [_mapManager start:@"8gm6oQZaH3AwubgmiauCrrzV"  generalDelegate:nil];
    

    [ShareSDK registerApp:@"108e8b04ddb2b"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
                 
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx2f4cf3217b39691c"
                                       appSecret:@"4b74f54e369267e71c2630d4624b5b12"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105261934"
                                      appKey:@"c6r4j17qTbt5vLjZ"
                                    authType:SSDKAuthTypeBoth];

                 break;
             case SSDKPlatformTypeRenren:
                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                               authType:SSDKAuthTypeBoth];
                                 break;
            default:
                 break;
         }
     }];
}

-(void)initGetOrderMassge
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isSelfOrderRecived) name:ORDERBYRECIVED object:nil];
}

//从网络判断订单是否被接受
-(void)isSelfOrderRecived
{
    self.orderTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(isSelfOrderRecivedFromNet) userInfo:nil repeats:YES];
}

////获得服务器发送的订单被接受的消息时做出应答的网络操作
-(void)isSelfOrderRecivedFromNet
{
    Network *net = [[Network alloc]init];
    NSNumber *orderId = [[NSUserDefaults standardUserDefaults]objectForKey:@"orderId"];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:orderId forKey:@"id"];
    [net accessNetUrl:URL_ISSELFORDERRECIVED parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            if ([[responseObject objectForKey:@"msg"]isEqualToString:@"已接单"]) {
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUnfinishedOrder"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"orderId"];
                //在正在显示的界面进行提示
                HintView *hint = [[[NSBundle mainBundle]loadNibNamed:@"HintView" owner:nil options:nil]firstObject];
                hint.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight+20);
                [self.window addSubview:hint];
                [self.window bringSubviewToFront:hint];
                
                [self.orderTimer invalidate];
            }
        }
    }];
}

-(void)loginUser
{
    NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    NSString *passWord = [[NSUserDefaults standardUserDefaults]objectForKey:PASSWORD];
    if (account && passWord) {
        NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
        [pass setObject:account forKey:ACCOUNT];
        [pass setObject:passWord forKey:PASSWORD];
        Network *net = [[Network alloc]init];
        [net accessNetUrl:URL_LOGIN parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUserLogin"];
            }
        }];
    }
}

-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSDictionary *posit = [NSDictionary dictionaryWithObject:userLocation forKey:@"userLocation"];
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_CHANGE object:nil userInfo:posit];
    self.lat = userLocation.location.coordinate.latitude;
    self.lng = userLocation.location.coordinate.longitude;
    
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = userLocation.location.coordinate;
    [self.geosearch reverseGeoCode:option];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"]) {
        
        if (self.locationTimer == nil) {
            self.locationTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateUserLocation) userInfo:nil repeats:YES];
        }
    }
}

#pragma 反地理编码代理方法
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSString *position = [NSString stringWithFormat:@"%@%@%@",result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
    self.curPosition = position;
    [[NSUserDefaults standardUserDefaults]setObject:result.addressDetail.city forKey:@"curCity"];
    self.curCity = result.addressDetail.city;
//    [self updateUserLocation];
}

//进行位置上传
-(void)updateUserLocation
{
//    if (_curPosition) {
//        NSNumber *Lng = [NSNumber numberWithDouble:_lng];
//        NSNumber *Lat = [NSNumber numberWithDouble:_lat];
//        NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
//        //判断是否登陆,登陆后才能网络上传位置
//        if (account) {
//            NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
//            [pass setObject:account forKey:ACCOUNT];
//            [pass setObject:Lng forKey:@"lng"];
//            [pass setObject:Lat forKey:@"lat"];
//            [pass setObject:_curPosition forKey:@"pPosition"];
//            Network *net = [[Network alloc]init];
//            [net accessNetUrl:URL_SAVEPOSITION parameters:pass success:nil];
//        }
//    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    [_locationManager stopUserLocationService];
    self.locationManager.delegate = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSUserDefaults standardUserDefaults]synchronize];
}




- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
    
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self alipaySuccess:resultDic];
        }];
        return YES;
    }
   
    
    return  [WXApi handleOpenURL:url delegate:self];
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self alipaySuccess:resultDic];
        }];
        return YES;

    }

    return  [WXApi handleOpenURL:url delegate:self];
    
    
}


- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
    
}


//微信支付回调函数
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果
        if (resp.errCode == 0) {
            PayResultViewController *view = [[PayResultViewController alloc]init];
            
            [_navigation pushViewController:view animated:YES];
        }
        else
        {
            PayFailViewController *fail = [[ PayFailViewController alloc]init];
            [_navigation pushViewController:fail animated:YES];
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WXPayComplate" object:nil];
    }
}

-(void)alipaySuccess:(NSDictionary*)resultDic
{
    NSString *code = [resultDic objectForKey:@"resultStatus"];
    if ([code isEqualToString:@"9000"]) {
        
        PayResultViewController *view = [[PayResultViewController alloc]init];
        
        [_navigation pushViewController:view animated:YES];
        
        
    }else if ([code isEqualToString:@"4000"] || [code isEqualToString:@"6002"])
    {
        
        PayFailViewController *fail = [[ PayFailViewController alloc]init];
        [_navigation pushViewController:fail animated:YES];
        
    }
}

@end
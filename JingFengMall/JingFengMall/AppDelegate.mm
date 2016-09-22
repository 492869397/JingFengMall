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
#import "CIA_SDK/CIA_SDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    CarMainViewController *carView = [[CarMainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:carView];
    
    //统一设置导航栏颜色
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:[UIColor redColor]];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -70) forBarMetrics:UIBarMetricsDefault];
    
    [self initManager];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
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
//    self.locationManager.distanceFilter = 0.5;
    self.locationManager.headingFilter = 5;
    [self.locationManager startUserLocationService];
    
    self.geosearch = [[BMKGeoCodeSearch alloc]init];
    self.geosearch.delegate = self;
    
    //手机号验证
    [CIA initWithAppId:@"03f9cac2d4844273b8f584cb26417760" authKey:@"95ac31ae7b45426493fac87ad4ca108a"];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUnfinishedOrder"]) {
        self.orderTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(isSelfOrderRecivedFromNet) userInfo:nil repeats:YES];
    }
}

// 百度地图鉴权
-(void)baiduMapPermisson
{
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    [_mapManager start:@"a7zQyxx2Ag5u8mgFN1Z8tVCg"  generalDelegate:self];
}

#pragma 百度地图授权代理
//- (void)onGetPermissionState:(int)iError
//{
//    NSLog(@"授权错误 %d",iError);
//}
//
//- (void)onGetNetworkState:(int)iError
//{
//    NSLog(@"网络错误 %d",iError);
//}

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
    NSString *position = [NSString stringWithFormat:@"%@,%@",result.addressDetail.district,result.addressDetail.streetName];
    self.curPosition = position;
    [[NSUserDefaults standardUserDefaults]setObject:result.addressDetail.city forKey:@"curCity"];
    self.curCity = result.addressDetail.city;
//    [self updateUserLocation];
}

//进行位置上传
-(void)updateUserLocation
{
    if (_curPosition) {
        NSNumber *Lng = [NSNumber numberWithDouble:_lng];
        NSNumber *Lat = [NSNumber numberWithDouble:_lat];
        NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
        //判断是否登陆,登陆后才能网络上传位置
        if (account) {
            NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
            [pass setObject:account forKey:ACCOUNT];
            [pass setObject:Lng forKey:@"lng"];
            [pass setObject:Lat forKey:@"lat"];
            [pass setObject:_curPosition forKey:@"pPosition"];
            Network *net = [[Network alloc]init];
            [net accessNetUrl:URL_SAVEPOSITION parameters:pass success:nil];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [_locationManager stopUserLocationService];
    self.locationManager.delegate = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end

//
//  CommitHouseOrderViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CommitHouseOrderViewController.h"
#import "AttornView.h"
#import "SJAccount.h"
#import "priceModel.h"
#import "ZhiFuView.h"
#import "MBProgressHUD.h"


@interface CommitHouseOrderViewController ()

@property (nonatomic ,strong)AttornView *AtView;

@property (strong,nonatomic)MBProgressHUD *HUB;

- (IBAction)putBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblUnits;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblTimeTwo;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UILabel *lblBeizhu;
@property (strong, nonatomic) IBOutlet UILabel *lblMoney;

@property (strong,nonatomic)NSNumber *JFCoin;

@property (weak, nonatomic) IBOutlet UILabel *canUseJingFengCoin;
@property (weak, nonatomic) IBOutlet UILabel *minusMoney;



@property (strong,nonatomic) NSNumber *price;


@end

@implementation CommitHouseOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交订单";
    
    
    priceModel *user = [SJAccount user];
    self.lblType.text = user.type;
    self.lblPrice.text = user.price;
    self.lblTime.text = self.strTime;
    
    
    NSArray *pArr =[user.price componentsSeparatedByString:@"/"];
    NSString *pStr1=[pArr objectAtIndex:1];
    self.lblUnits.text = pStr1;
    self.lblAddress.text = self.strOne;
    //未获得
    self.lblTimeTwo.text = self.strTimeTwo;
    self.lblPhone.text = self.strTwo ;
    self.lblBeizhu.text = self.strThree;
    
    NSString *moneyStr=[pArr objectAtIndex:0];
    float floatMoneyStr = [moneyStr floatValue];
    float floatTimeStr = [self.strTime floatValue];
    float payMoney = floatMoneyStr * floatTimeStr;
    NSString *stringFloat = [NSString stringWithFormat:@"%.2f",payMoney];
    
    self.price = [NSNumber numberWithFloat:payMoney];
    
    self.lblMoney.text = stringFloat;
    
    [_isUseJingFengMoney setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [_isUseJingFengMoney setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    
    
    [self getCanUseJingFengMoney];
   
}


-(void)getCanUseJingFengMoney
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:2];
    
    NSNumber *price = [NSNumber numberWithFloat:_lblMoney.text.floatValue];
    [pass setObject:price forKey:@"price"];
    
    NSString *userPhone = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:userPhone forKey:@"userPhone"];
    
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/selectMCoinNumberForHouse.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            NSString *a = responseObject[@"msg"];
            NSNumber *b = responseObject[@"coinNumber"];
            
            NSInteger coin = a.integerValue < b.integerValue?a.integerValue:b.integerValue;
            _JFCoin = [NSNumber numberWithInteger:coin];
            
            _canUseJingFengCoin.text = [NSString stringWithFormat:@"使用京锋币%@个",_JFCoin];
            _minusMoney.text = [NSString stringWithFormat:@"抵扣%@元",_JFCoin];
            
            
            [self calculatePrice];
            
        }
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 serPhone	String	用户手机号(账号)	非空
 typeID	int	服务类型ID	非空
 address	String	订单填写的地址	非空
 updoorTime	Date	上门时间	非空
 phone	String	预留电话	非空
 remarks	String	备注	非空
 employeeID	int	选择的雇员ID	非空
 serviceTime	float	服务时间（几小时）	非空
 voucherMoney	float	现金券金额	非空
 */
//提交order
- (IBAction)putBtn:(id)sender {
  
    NSString *url = @"http://123.57.28.11:8080/jfsc_app/addHOrder.do";
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    [pass setObject:self.strTypeID forKey:@"typeID"];
    [pass setObject:_lblAddress.text forKey:@"address"];
    [pass setObject:_strTimeTwo forKey:@"updoorTime"];
    [pass setObject:_lblPhone.text forKey:@"phone"];
    [pass setObject:_lblBeizhu.text forKey:@"remarks"];
    [pass setObject:_AuntID forKey:@"employeeID"];
    [pass setObject:_lblTime.text forKey:@"serviceTime"];

    if (_JFCoin) {
        
        [pass setObject:_JFCoin forKey:@"coinNumber"];
        
    }
    
    NSNumber *la = [NSNumber numberWithFloat:_lat];
    [pass setObject:la forKey:@"lat"];
    NSNumber *ln = [NSNumber numberWithFloat:_lng];
    [pass setObject:ln forKey:@"lng"];
    
    
    
    _HUB = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUB];
    _HUB.mode = MBProgressHUDModeIndeterminate;
    _HUB.label.text = @"Loading";
    [_HUB showAnimated:YES];
    
    
    AFHTTPRequestOperationManager *mgr2=[AFHTTPRequestOperationManager manager];
    [mgr2 POST:url parameters:pass  success:^(AFHTTPRequestOperation * operation, id responsObject)
     {
         [_HUB hideAnimated:NO];

         if ([[responsObject objectForKey:@"code"] isEqualToNumber:@1]) {
    
             [SJAccount saveUser:[priceModel initWithDict:[NSDictionary dictionaryWithDictionary:responsObject]]];
             [SJAccount user];
      
             [self enterPay:(responsObject[@"id"])];
             
    
         }
         else
         {
             NSString *msg = [responsObject objectForKey:@"msg"];
             Toast *toa = [Toast makeText:msg];
             [toa showWithType:ShortTime];
         }
         
         
         
     } failure:^(AFHTTPRequestOperation * operation, NSError * error)
     {
         [_HUB hideAnimated:NO];
         
         Toast *toa = [Toast makeText:@"网络连接失败请重试"];
         [toa showWithType:ShortTime];
         
     }];
    
}
//调用支付界面
- (void)enterPay:(NSNumber*)num {
    
    ZhiFuView *view= [[[NSBundle mainBundle]loadNibNamed:@"ZhiFuView" owner:nil options:nil]firstObject];
    
    [[[UIApplication sharedApplication] keyWindow]addSubview:view];
    
    view.delegate = self;
    view.num = num;
    view.payFlag = 2;//用于标志支付的url
    
    CGRect frame = [[UIApplication sharedApplication] keyWindow].frame;
    
    view.frame = CGRectMake(0, 0, 0, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = frame;
    }];
    
}

- (IBAction)isUseJingFengCoinButtinClick:(UIButton *)sender {
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        
    }else
    {
        sender.selected = YES;
    }
    
    [self calculatePrice];
}

-(void)calculatePrice
{
    double minus;
    if (_isUseJingFengMoney.selected) {
        minus = _JFCoin.doubleValue ;
    }else
    {
        minus = 0;
    }
    
    _lblMoney.text = [NSString stringWithFormat:@"%.2lf",_price.doubleValue - minus];
    
}


@end
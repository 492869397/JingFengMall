//
//  CommitOrderViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CommitOrderViewController.h"
#import "SelectAddrssViewController.h"
#import "SelectBillViewController.h"
#import "GoodsModel.h"
#import "ZhiFuView.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

@interface CommitOrderViewController ()

@property(strong,nonatomic)MBProgressHUD *HUD;


@property(copy,nonatomic)NSMutableString *commodityIDNumber;

@property (weak, nonatomic) IBOutlet UILabel *returnJingFengMoney;
@property (weak, nonatomic) IBOutlet UIButton *isUseJingFengMoney;

@property(strong,nonatomic)NSNumber *canUseJingFengMoney;

@property(assign,nonatomic)float discount;

@end

@implementation CommitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"结算";
    
    [_isUseJingFengMoney setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [_isUseJingFengMoney setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    _isUseJingFengMoney.selected = NO;
    
    _canUseJingFengMoney = @0;
    
    _discount = 1.0;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setLabels];
    
    [self getCanUseJingFengMoney];
}

-(NSMutableString*)commodityIDNumber
{
    if (!_commodityIDNumber) {
        
        _commodityIDNumber = [NSMutableString string];
        
        for (GoodsModel *goods in _array) {
            
            if ([_commodityIDNumber isEqualToString:@""]) {
                
                [_commodityIDNumber appendString:[NSString stringWithFormat:@"%@",goods.goodsID]];
                [_commodityIDNumber appendString:[NSString stringWithFormat:@",%@",goods.goodsNumber]];
                
            }else
            {
                [_commodityIDNumber appendString:[NSString stringWithFormat:@",%@",goods.goodsID]];
                [_commodityIDNumber appendString:[NSString stringWithFormat:@",%@",goods.goodsNumber]];
            }
        }

        
    }
    
    return _commodityIDNumber;

}

-(void)getCanUseJingFengMoney
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [pass setObject:self.commodityIDNumber forKey:@"commodityIDNumber"];
    
    NSString *userPhone = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:userPhone forKey:@"userPhone"];
    
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/selectMCoinNumber.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            NSString *a = responseObject[@"msg"];
            NSNumber *b = responseObject[@"coinNumber"];
            
            NSInteger coin = a.integerValue < b.integerValue?a.integerValue:b.integerValue;
            _canUseJingFengMoney = [NSNumber numberWithInteger:coin];
            
            _canUseMoney.text = [NSString stringWithFormat:@"使用京锋币%@个",_canUseJingFengMoney];
            
            _minusMoney.text = [NSString stringWithFormat:@"抵扣%@元",_canUseJingFengMoney];
            
            NSNumber *d = (NSNumber*)(responseObject[@"discount"]);
            
            _discount = d.floatValue;
            
            [self calculatePrice];
        
        }
    }];

}


-(void)setLabels
{
    _totalPrice = 0;
    
    NSInteger goodsNumber = 0;
    for (GoodsModel *goods in _array) {
        _totalPrice += goods.price.doubleValue*goods.goodsNumber.integerValue;
        goodsNumber += goods.goodsNumber.integerValue;
    }
    
    GoodsModel *goods = _array[0];
    NSString *url = [goods.photo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.photo sd_setImageWithURL:[NSURL URLWithString:url]];
    
    self.nameLabel.text = goods.title;
    self.number.text = [NSString stringWithFormat:@"共%ld件商品",(long)goodsNumber];
    
    //计算价格
    self.price.text = [NSString stringWithFormat:@"¥%.2lf",_totalPrice];

    
    double minus = _totalPrice - (_totalPrice - _canUseJingFengMoney.doubleValue) * _discount;
    
    self.minusPrice.text = [NSString stringWithFormat:@"-    ¥%.2lf",minus];
    
    self.finalPrice.text = [NSString stringWithFormat:@"¥%.2lf",_totalPrice - minus];
    
}

//重新计算价格并显示，当从网络获取到应该使用的money时
-(void)calculatePrice
{
    double minus;
    if (_isUseJingFengMoney.selected) {
        minus = _totalPrice - (_totalPrice - _canUseJingFengMoney.doubleValue) * _discount;
    }else
    {
        minus = _totalPrice - _totalPrice  * _discount;
    }
    
    
    
    self.minusPrice.text = [NSString stringWithFormat:@"-    ¥%.2lf",minus];
    
    self.finalPrice.text = [NSString stringWithFormat:@"¥%.2lf",_totalPrice - minus];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lookGoodsDetail:(id)sender {
}

- (IBAction)selectGetGoodsPlace:(UITapGestureRecognizer *)sender {
    SelectAddrssViewController *address = [[SelectAddrssViewController alloc]init];
    address.delegate = self;
    [self.navigationController pushViewController:address animated:YES];
}

- (IBAction)selectBill:(UITapGestureRecognizer *)sender {
    
    SelectBillViewController *bill = [[SelectBillViewController alloc]init];
    [self.navigationController pushViewController:bill animated:YES];
    
}

- (IBAction)isUseJingFengMonyButtonClick:(UIButton*)sender {
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        
    }else
    {
        sender.selected = YES;
    }
    
    
    [self calculatePrice];

}

- (IBAction)confirm:(UIButton *)sender {
    
    if (!(self.con)) {
        
        Toast *toa = [Toast makeText:@"请选择收货地址"];
        [toa showWithType:ShortTime];
        
        return;
    }
    
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.label.text = @"Loading";
    [_HUD showAnimated:YES];

    
    
    
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    
    if (_isUseJingFengMoney.selected) {
        
        [pass setObject:_canUseJingFengMoney forKey:@"coinNumber"];
    }
    
    [pass setObject:user forKey:@"userPhone"];
    [pass setObject:_con.Id forKey:@"userAddressID"];
    [pass setObject:_commodityIDNumber forKey:@"commodityIDNumber"];
    
    if (_bill) {
        [pass setObject:_bill forKey:@"invoice"];
    }
    
    
    NSString *url = [@"http://123.57.28.11:8080/jfsc_app/addMallOrder.do" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[AFHTTPSessionManager manager]POST:url parameters:pass success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [_HUD hideAnimated:NO];

        
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
            
            [self enterPay:([responseObject objectForKey:@"id"])];
            
        }else
        {
            NSString *msg = [responseObject objectForKey:@"msg"];
            Toast *toa = [Toast makeText:msg];
            [toa showWithType:ShortTime];
        }

        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        [_HUD hideAnimated:NO];


        Toast *toa = [Toast makeText:@"网络连接失败请重试"];
        [toa showWithType:ShortTime];
        
    }];
    
}

- (void)enterPay:(NSNumber*)num {
    
    ZhiFuView *view= [[[NSBundle mainBundle]loadNibNamed:@"ZhiFuView" owner:nil options:nil]firstObject];
    
    [[[UIApplication sharedApplication] keyWindow]addSubview:view];
    
    view.delegate = self;
    view.num = num;
    view.payFlag = 1;//支付的flag，用来标志支付的url
    
    
    CGRect frame = [[UIApplication sharedApplication] keyWindow].frame;
    
    view.frame = CGRectMake(0, 0, 0, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = frame;
    }];
    
}


@end
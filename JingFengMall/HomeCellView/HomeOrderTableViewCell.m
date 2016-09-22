//
//  HomeOrderTableViewCell.m
//  JingFengMall
//
//  Created by len on 16/5/7.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeOrderTableViewCell.h"
#import "HomeAssessViewController.h"
#import "HomeInformationViewController.h"
#import "HomeSucceedViewController.h"
#import "ZhiFuView.h"
#import "HomeOrderModel.h"
#import "PositionViewController.h"

@interface HomeOrderTableViewCell()


@property (strong, nonatomic) IBOutlet UILabel *PriceLbl;


@property (strong, nonatomic) IBOutlet UILabel *Timelbl;

@property (strong, nonatomic) IBOutlet UILabel *Addresslbl;

- (IBAction)LinkManBtn:(id)sender;

- (IBAction)FinishBtn:(id)sender;
- (IBAction)PingJiaBtn:(id)sender;
- (IBAction)DetailsClick:(id)sender;
- (IBAction)LookUpBtn:(id)sender;

@end
@implementation HomeOrderTableViewCell




-(void)setModel:(HomeOrderModel *)model
{
    
    _model = model;
    
    //[NSString stringWithFormat:@"%@", dic[@"onTime"]
    [self.Servicelbl setText:[NSString stringWithFormat:@"%@",model.type]];
    [self.PriceLbl setText:[NSString stringWithFormat:@"%@",model.price]];
    [self.Timelbl setText:[NSString stringWithFormat:@"%@",model.updoorTime]];
    [self.Addresslbl setText:model.address];
    _employeeID = model.employeeID;
    NSLog(@"wwwwww====%@",_employeeID);
    _strID = model.typeId;
    NSLog(@"aaaa====%@",_strID);
    _strorderID = model.Iid;
    NSLog(@"aaaa====%@",_strorderID);

    
    
}


- (IBAction)FinishingBtn:(id)sender {
    
    NSLog(@"");
    [self enterPay:[NSNumber numberWithInteger:_strorderID.integerValue]];
}


- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)LinkManBtn:(id)sender {

    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:10086"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    Toast *toa = [Toast makeText:@"呼叫客服中..."];
    [toa showWithType:ShortTime];
    [self addSubview:callWebview];
}

//调用支付界面
- (void)enterPay:(NSNumber*)num {
    
    ZhiFuView *view= [[[NSBundle mainBundle]loadNibNamed:@"ZhiFuView" owner:nil options:nil]firstObject];
    
    [[[UIApplication sharedApplication] keyWindow]addSubview:view];
    
    view.delegate = self.delegate;
    view.num = num;
    view.payFlag = 2; //2 代表家政的订单
    
    CGRect frame = [[UIApplication sharedApplication] keyWindow].frame;
    
    view.frame = CGRectMake(0, 0, 0, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = frame;
    }];
    
}
- (IBAction)FinishBtn:(id)sender {
    /*元素字段	字段类型	默认值或备注说明	是否为空
     id	int	确认要完成的订单ID	非空*/
    [self netWorking];
    
}
- (IBAction)PingJiaBtn:(id)sender {
    [self netWorking];
    
}
- (IBAction)LookUpBtn:(id)sender{
    PositionViewController *wuliu = [[PositionViewController alloc]init];
    
    wuliu.order =  _model;
    
    [self.delegate.navigationController pushViewController:wuliu animated:YES];
}
- (IBAction)DetailsClick:(id)sender {
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    HomeInformationViewController *HIVC = [[HomeInformationViewController alloc]init];
    HIVC.typeId = _strID;
    HIVC.employeeID = _employeeID;
    HIVC.btnSelect.backgroundColor = [UIColor clearColor];
    [nav pushViewController:HIVC animated:YES];
}

-(void)netWorking{
    
    NSString *url = @"http://123.57.28.11:8080/jfsc_app/updateHOrderForPaymentStateByID.do";
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    
    [pass setObject:_strorderID forKey:@"id"];
    AFHTTPRequestOperationManager *mgr2=[AFHTTPRequestOperationManager manager];
    [mgr2 POST:url parameters:pass  success:^(AFHTTPRequestOperation * operation, id responsObject)
     {
         
         if ([[responsObject objectForKey:@"code"] isEqualToNumber:@1]) {
             Toast *toa = [Toast makeText:@"订单已完成..."];
             [toa showWithType:ShortTime];
             UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
             HomeAssessViewController *HAVC = [[HomeAssessViewController alloc]init];
             HAVC.orderID = _strorderID;
             [nav pushViewController:HAVC animated:YES];
             
         }
         else
         {
             NSString *msg = [responsObject objectForKey:@"msg"];
             Toast *toa = [Toast makeText:msg];
             [toa showWithType:ShortTime];
         }
         
     } failure:^(AFHTTPRequestOperation * operation, NSError * error)
     {
         
         Toast *toa = [Toast makeText:@"网络连接失败请重试"];
         [toa showWithType:ShortTime];
         
     }];
}

@end
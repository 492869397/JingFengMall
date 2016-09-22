//
//  HomeOrderModel.m
//  JingFengMall
//
//  Created by len on 16/5/20.
//  Copyright © 2016年 yunlan. All rights reserved.
//
/*address = "北京北京市东城区";
 completeState = "未完成";
 createTime = 1463709211000;
 employeeID = 6;
 id = 51;
 orderMoney = 100;
 "out_trade_no" = 052009532993487;
 payStr = "partner=\\\"2088221202798599\\\"&seller_id=\\\"rongronggroup@163.com\\\"&out_trade_no=\\\"052009532993487\\\"&subject=\\\"日常清洁服务\\\"&body=\\\"家政服务\\\"&total_fee=\\\"100.0\\\"&notify_url=\\\"http://123.57.28.11:8080/jfsc_app/aliPayReturn.do\\\"&service=\\\"mobile.securitypay.pay\\\"&payment_type=\\\"1\\\"&_input_charset=\\\"utf-8\\\"&it_b_pay=\\\"30m\\\"&return_url=\\\"m.alipay.com\\\"&sign=\\\"MH3owX50OMZUoUmCyHa25HIgXta1ykShR5wQs2TZHddxQCr5ECBWfDDDZVBdAk80rNjlnYvLHNu73Ln79nUeOc01Unu2gdX8Pzs9ENRpnUMMHvoBWYEHHQxLVP2dFpKxZ8z5GHjcwZka2Ke8bQv7ilFRM9yHMjLiSrOzNmHh1Ng=\\\"&sign_type=\\\"RSA\\\"";
 paymentState = "待完成";
 paymentTime = 1463709214000;
 phone = "qwerty yip ";
 price = "<null>";
 remarks = "";
 serviceTime = 1;
 typeID = 8;
 updoorTime = 1;
 userPhone = 15910424144;
 voucherMoney = 0;
 "weixin_out_trade_no" = 221463709209023;
 "weixin_payStr" = "{\\\"appid\\\":\\\"wx2f4cf3217b39691c\\\",\\\"timestamp\\\":\\\"1463709211\\\",\\\"noncestr\\\":\\\"4vwvn1shotwjsmp66jrjjba4oq76qks1\\\",\\\"package\\\":\\\"Sign=WXPay\\\",\\\"sign\\\":\\\"E2FA2D64E29208350A376D038472FD91\\\",\\\"partnerid\\\":\\\"1328614701\\\",\\\"prepayid\\\":\\\"wx201605200953319a941d42180387413580\\\"}";*/
#import "HomeOrderModel.h"

@implementation HomeOrderModel


-(instancetype)initWithDict:(NSDictionary *)dic
{
    
    if ( self = [super init])
    {
    
         self.price = dic[@"price"];
         self.updoorTime = dic[@"updoorTime"];
         self.address = dic[@"address"];
         self.type = dic[@"type"];
         self.employeeID = dic[@"employeeID"];
         self.typeId = dic[@"typeID"];
         self.phone = dic[@"phone"];
         self.remarks = dic[@"remarks"];
         self.Iid = dic[@"id"];


    }
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dic
{
    return [[self alloc]initWithDict:dic];
}


@end

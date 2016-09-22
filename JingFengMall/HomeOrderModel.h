//
//  HomeOrderModel.h
//  JingFengMall
//
//  Created by len on 16/5/20.
//  Copyright © 2016年 yunlan. All rights reserved.
//
/*
 
 address = "北京北京市东城区";
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
 "weixin_payStr" = "{\\\"appid\\\":\\\"wx2f4cf3217b39691c\\\",\\\"timestamp\\\":\\\"1463709211\\\",\\\"noncestr\\\":\\\"4vwvn1shotwjsmp66jrjjba4oq76qks1\\\",\\\"package\\\":\\\"Sign=WXPay\\\",\\\"sign\\\":\\\"E2FA2D64E29208350A376D038472FD91\\\",\\\"partnerid\\\":\\\"1328614701\\\",\\\"prepayid\\\":\\\"wx201605200953319a941d42180387413580\\\"}";
 
 */
#import <Foundation/Foundation.h>

@interface HomeOrderModel : NSObject

@property (nonatomic ,copy)NSString *price;
@property (nonatomic ,copy)NSString *type;
@property (nonatomic ,copy)NSString *updoorTime;
@property (nonatomic ,copy)NSString *address;
@property (nonatomic ,copy)NSString *employeeID;
@property (nonatomic ,copy)NSString *Iid;
@property (nonatomic ,copy)NSString *typeId;
@property (nonatomic ,copy)NSString *phone;
@property (nonatomic ,copy)NSString *remarks;




-(instancetype)initWithDict:(NSDictionary *)dic;
+(instancetype)initWithDict:(NSDictionary *)dic;


@end

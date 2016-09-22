//
//  OrderStatusViewController.m
//  JingFengMall
//
//  Created by len on 16/1/26.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "OrderTableViewController.h"
#import "DiverPositionViewController.h"

@interface OrderStatusViewController ()

@end

@implementation OrderStatusViewController

-(void)setContent
{
    self.startPosition.text = self.order.startPosition;
    self.endPosition.text = self.order.endPosition;
    self.orderStatus.text = [NSString stringWithFormat:@"状态: %@",self.order.completeState];
    
    NSDateFormatter *dateform = [[NSDateFormatter alloc]init];
    [dateform setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *time = [dateform stringFromDate:self.order.createTime];
    self.createTime.text = time;
    self.carBrand.text = @"";
}

- (IBAction)lookPosition:(id)sender {
    DiverPositionViewController *position = [[DiverPositionViewController alloc]init];
    position.phoneNumber = self.order.receiveUserPhone;
    position.order = self.order;
    [((OrderTableViewController*)self.delegate).navigationController pushViewController:position animated:YES];
}

- (IBAction)cancelOrder:(id)sender {
    [self cancelOrderFromNet];
}

- (IBAction)callDiver:(id)sender {
    if ([self.order.completeState isEqualToString:@"已接单"]) {
        NSString *phoneNumber = self.order.receiveUserPhone;
        NSString *phone = [NSString stringWithFormat:@"tel://%@",phoneNumber];
        NSURL *url = [NSURL URLWithString:phone];
        [[UIApplication sharedApplication] openURL:url];
    }else
    {
        Toast *toa = [Toast makeText:@"您的订单还未被接收"];
        [toa showWithType:ShortTime];
    }
    
}

-(void)cancelOrderFromNet
{
    Network *net = [[Network alloc]init];
    NSNumber *orderId = [NSNumber numberWithInteger:self.order.orderId];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:orderId forKey:@"id"];
    [net accessNetUrl:URL_CANCELORDER parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            [(OrderTableViewController*)self.delegate getordersInfo];
            Toast *toast = [Toast makeText:@"订单取消成功"];
            [toast showWithType:ShortTime];
            
        }else
        {
            Toast *toast = [Toast makeText:@"订单取消失败"];
            [toast showWithType:ShortTime];
            
        }
    }];
}

@end

//
//  OnlyOrderViewController.m
//  JingFengMall
//
//  Created by len on 16/1/26.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "OnlyOrderViewController.h"
#import "DiverPositionViewController.h"
#import "DiverOrderTableViewController.h"
#import "DiverGotOrderTableViewController.h"

@interface OnlyOrderViewController ()

@end

@implementation OnlyOrderViewController

-(void)setContent
{
    OrderModel *order = self.order;
    self.startPosition.text = order.startPosition;
    self.endPosition.text = order.endPosition;
    self.staus.text = [NSString stringWithFormat:@"状态: %@",order.completeState];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *time = [formatter stringFromDate:order.createTime];
    self.endTime.text = time;

}

- (IBAction)detailView:(id)sender {
    DiverPositionViewController *view = [[DiverPositionViewController alloc]init];
    view.phoneNumber = self.order.orderUserPhone;
    view.order = self.order;
    [((DiverOrderTableViewController*)self.delegate).navigationController pushViewController:view animated:YES];
}

- (IBAction)callPhone:(id)sender {
    NSString *phoneNumber = self.order.orderUserPhone;
    NSString *phone = [NSString stringWithFormat:@"tel://%@",phoneNumber];
    NSURL *url = [NSURL URLWithString:phone];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)getOrder:(id)sender {
    Network *net = [[Network alloc]init];
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    NSNumber *orderId = [NSNumber numberWithInteger:self.order.orderId];
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:orderId forKey:@"id"];
    [pass setObject:phoneNumber forKey:@"receiveUserPhone"];
    [net accessNetUrl:URL_GRABORDER parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            [[NSUserDefaults standardUserDefaults]setObject:orderId forKey:@"gotOrderId"];
            DiverGotOrderTableViewController *diverOrder = [[DiverGotOrderTableViewController alloc]init];
            self.order.completeState = @"已接单";
            diverOrder.order = self.order;
            [((DiverOrderTableViewController*)self.delegate).navigationController pushViewController:diverOrder animated:YES];
        }else
        {

        }
    }];
}

@end

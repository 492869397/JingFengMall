//
//  UnpaymentTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "UnpaymentTableViewCell.h"
#import "MyOrderViewController.h"
#import "ZhiFuView.h"

@implementation UnpaymentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)payOrder:(id)sender {
        
    ZhiFuView *view= [[[NSBundle mainBundle]loadNibNamed:@"ZhiFuView" owner:nil options:nil]firstObject];
    
    [[[UIApplication sharedApplication] keyWindow]addSubview:view];
    
    view.delegate = self.delegate;
    view.num = self.order.commodityid;
    view.payFlag = 1;
    
    CGRect frame = [[UIApplication sharedApplication] keyWindow].frame;
    
    view.frame = CGRectMake(0, 0, 0, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = frame;
    }];
    
}

- (IBAction)cancelOrder:(id)sender {
    
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *Id = [NSString stringWithFormat:@"%@",self.order.commodityid];
    [pass setObject:Id forKey:@"id"];
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/deleteMallOrder.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            [(MyOrderViewController*)self.delegate getData];
            
        }
        
        NSString *msg = [responseObject objectForKey:@"msg"];
        Toast *toa = [Toast makeText:msg];
        [toa showWithType:ShortTime];
        
    }];

}

@end
//
//  UngetTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "UngetTableViewCell.h"
#import "MyOrderViewController.h"
#import "WuLiuViewController.h"

@implementation UngetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)lookEMS:(id)sender {
    
    WuLiuViewController *wuliu = [[WuLiuViewController alloc]init];
    
    wuliu.order = self.order;
    
    [self.delegate.navigationController pushViewController:wuliu animated:YES];
    
}

- (IBAction)confirmGetGoods:(id)sender {
    
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:1];
    [pass setObject:self.order.commodityid forKey:@"id"];
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/okMallOrder.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            Toast *toa = [Toast makeText:@"确认收货成功"];
            [toa showWithType:ShortTime];
            
        }else
        {
            Toast *toa = [Toast makeText:@"操作失败"];
            [toa showWithType:ShortTime];
        }
        
        [(MyOrderViewController*)(self.delegate) getData];
        
    }];
    
}
@end

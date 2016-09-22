//
//  AddressTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressTableViewController.h"
#import "AddReciverViewController.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)edit:(id)sender {
    AddReciverViewController *view = [[AddReciverViewController alloc]init];
    view.con = self.con;
    
    [((AddressTableViewController *)self.delegate).navigationController pushViewController:view animated:YES];
}

- (IBAction)deleteReciver:(id)sender {
    
    Network *net = [[Network alloc]init];
    
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:1];
    [pass setObject:_con.Id forKey:@"id"];
    
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/deleteAddress.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            [(AddressTableViewController*)self.delegate getDataFromNet];
            
        }
        
    }];
    
}



@end

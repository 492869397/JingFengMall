//
//  SetUpViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "SetUpViewController.h"
#import "ExplainViewController.h"
#import "HelpViewController.h"

#import "Network.h"

@interface SetUpViewController ()

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.array = [[NSMutableArray alloc]init];
    
    [self getContent];
}

-(void)getContent
{
    Network *net = [[Network alloc]init];
    [net accessNetUrl:URL_SETUP parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            NSArray *arr = [responseObject objectForKey:@"list"];
            NSString *str = [[arr objectAtIndex:0]objectForKey:@"photo"];
            NSString *s  = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:s];
            [_array addObject:url];
            
            NSString *str1 = [[arr objectAtIndex:1]objectForKey:@"photo"];
            NSString *s1  = [str1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url1 = [NSURL URLWithString:s1];
            [_array addObject:url1];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)help:(id)sender {
    HelpViewController *help = [[HelpViewController alloc]init];
    
    [self.navigationController pushViewController:help animated:NO];
    
    help.url = _array[1];
}

- (IBAction)explian:(id)sender {
    ExplainViewController *plain = [[ExplainViewController alloc]init];
    
    [self.navigationController pushViewController:plain animated:NO];
    
    plain.url = _array[0];
}
@end

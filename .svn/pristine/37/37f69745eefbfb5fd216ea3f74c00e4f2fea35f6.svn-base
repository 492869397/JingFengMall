//
//  SexTableViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "SexTableViewController.h"
#import "RDVTabBarController.h"

@interface SexTableViewController ()

@end

@implementation SexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.tableView.tableFooterView = [[UIView alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.rdv_tabBarController.tabBarHidden == NO) {
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (self.rdv_tabBarController.tabBarHidden == YES) {
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
    }
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"男";
        
    }else if(indexPath.row == 1)
    {
        cell.textLabel.text = @"女";
        
    }else
    {
        cell.textLabel.text = @"保密";
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:2];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:[tableView cellForRowAtIndexPath:indexPath].textLabel.text forKey:@"sex"];
    [pass setObject:user forKey:@"userPhone"];
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/updateSex.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            Toast *toa = [Toast makeText:@"修改失败"];
            [toa showWithType:ShortTime];
        }
    }];
}

@end

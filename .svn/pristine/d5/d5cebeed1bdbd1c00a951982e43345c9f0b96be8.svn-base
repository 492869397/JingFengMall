//
//  SubDetailViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "SubDetailViewController.h"
#import "SubDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SubTableViewCell.h"


@interface SubDetailViewController ()

@end

@implementation SubDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    if (_array.count == 0) {
        Toast *toa = [Toast makeText:@"没有下级用户"];
        [toa showWithType:ShortTime];
    }
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_cellType == SubCellHaveMoneyLabel) {
        
        SubDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SubDetailTableViewCell" owner:nil options:nil]firstObject];
            
        }
        
        cell.subview.layer.borderWidth = 1;
        cell.subview.layer.cornerRadius = 5;
        
        NSDictionary *dic = _array[indexPath.row];
        cell.phone.text = [dic objectForKey:@"userPhone"];
        
        float d = [(NSNumber*)[dic objectForKey:@"createTime"] floatValue] /1000;
        NSDate *da = [NSDate dateWithTimeIntervalSince1970:d];
        
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:[NSString stringWithFormat:@"yyyy.MM.dd"]];
        NSString *date = [format stringFromDate:da];
        
        cell.date.text = date;
        
        NSString *money = [dic objectForKey:@"money"];
        cell.money.text = [NSString stringWithFormat:@"+%@元",money];
        
        cell.phone.text = [dic objectForKey:@"UserPhone"];
        
//        [cell.photo setImageWithURL:[dic objectForKey:@""]];
        
        return cell;
        
    }
    else
    {
        SubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SubTableViewCell" owner:nil options:nil]firstObject];
            
        }
        
        cell.subView.layer.borderWidth = 1;
        cell.subView.layer.cornerRadius = 5;
        
        NSDictionary *dic = _array[indexPath.row];
        cell.phone.text = [dic objectForKey:@"userPhone"];
        
        float d = [(NSNumber*)[dic objectForKey:@"subUserCreateTime"] floatValue] /1000;
        NSDate *da = [NSDate dateWithTimeIntervalSince1970:d];
        
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:[NSString stringWithFormat:@"yyyy.MM.dd"]];
        NSString *date = [format stringFromDate:da];
        
        cell.date.text = date;
        cell.phone.text = [dic objectForKey:@"subUserPhone"];
        [cell.photo sd_setImageWithURL:[dic objectForKey:@"subUserPhoto"]];
        
        return cell;
    }
    
    
}

@end

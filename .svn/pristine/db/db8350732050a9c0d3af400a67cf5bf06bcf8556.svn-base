//
//  CommentServicerViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CommentServicerViewController.h"
#import "CommentServicerTableViewCell.h"

@interface CommentServicerViewController ()

@end

@implementation CommentServicerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableview.rowHeight = 177;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentServicerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentServicerTableViewCell" owner:nil options:nil]firstObject];
    }
    
    
    
    
    return cell;
    
}

- (IBAction)changeAssort:(UISegmentedControl *)sender {
    
    NSLog(@"%ld",(long)sender.selectedSegmentIndex);
}

@end

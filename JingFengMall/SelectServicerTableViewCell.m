//
//  SelectServicerTableViewCell.m
//  JingFengMall
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "SelectServicerTableViewCell.h"
#import "HomeBeSpeakViewController.h"
#import "HomeInformationViewController.h"
#import "UIImageView+WebCache.h"

@interface SelectServicerTableViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@property (strong, nonatomic) IBOutlet UILabel *Auntlbl;
@property (strong, nonatomic) IBOutlet UILabel *lblOne;
@property (strong, nonatomic) IBOutlet UILabel *lblTwo;
@property (strong, nonatomic) IBOutlet UILabel *GradeNumlbl;
- (IBAction)selectBtn:(id)sender;
- (IBAction)infomationBtn:(id)sender;

@end

@implementation SelectServicerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setModel:(auntModel *)model
{
    _model = model;
   
    [self.Auntlbl setText:model.name];
    [self.GradeNumlbl setText:[NSString stringWithFormat:@"%@",model.score]];
    NSURL *url = [NSURL URLWithString:model.photo];
    [self.imageview sd_setImageWithURL:url];
    NSString *string = model.label;
    _strlbl = model.label;
    NSArray *pArr =[string componentsSeparatedByString:@","];
    NSString *strOne=[pArr objectAtIndex:0];
    NSString *strTwo=[pArr objectAtIndex:1];
    [self.lblOne setText:[NSString stringWithFormat:@"%@",strOne]];
    [self.lblTwo setText:[NSString stringWithFormat:@"%@",strTwo]];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectBtn:(id)sender {
//    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    [self.NavController popToViewController:HBSVC animated:YES];
    [self.NavController popViewControllerAnimated:YES];
    
    [self passData];
    
}

-(void)passData
{
    _myselectBlock([NSString stringWithFormat:@"%@",_model.Iid]);
    _myselectBlockTwo([NSString stringWithFormat:@"%@",_model.name]);
}


- (IBAction)infomationBtn:(id)sender {
//    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    HomeInformationViewController *HIFVC = [[HomeInformationViewController alloc]init];
    [self.NavController pushViewController:HIFVC animated:YES];
    
    HIFVC.delegate = self;
    
    HIFVC.employeeID =[NSString stringWithFormat:@"%@",_model.Iid];
    HIFVC.typeId = _typeID;
    NSLog(@"_typeID=====%@",_typeID);
}
@end
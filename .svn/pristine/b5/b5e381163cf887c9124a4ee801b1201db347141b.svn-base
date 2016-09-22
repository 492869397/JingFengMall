//
//  HomeThredViewController.m
//  JingFengMall
//
//  Created by len on 16/5/6.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeThredViewController.h"
#import "HomeBeSpeakViewController.h"
#import "priceModel.h"
#import "SJAccount.h"
#import "UIImageView+WebCache.h"
#import "HomeBeSpeakCarViewController.h"


#define URL @"http://123.57.28.11:8080/jfsc_app/selectHPhotoByTypeID.do"
@interface HomeThredViewController ()
- (IBAction)beSpokeBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property(nonatomic, strong) NSString *pricestring;
@property(nonatomic, strong) NSString *Typetring;
@end

@implementation HomeThredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部服务";
    NSMutableDictionary *params2=[NSMutableDictionary dictionary];
    params2[@"typeID"] = self.priceTypeStr;
//  params2[@"typeID"] = @"8";
//  NSLog(@"%@",params2);
    AFHTTPRequestOperationManager *mgr2=[AFHTTPRequestOperationManager manager];
    [mgr2 POST:URL parameters:params2  success:^(AFHTTPRequestOperation * operation, id responsObject)
     {
         
         
         NSMutableArray *dataArray = [NSMutableArray arrayWithArray:responsObject[@"list"]];
         [SJAccount saveUser:[priceModel initWithDict:[NSDictionary dictionaryWithDictionary:responsObject]]];
         priceModel *user = [SJAccount user];
         NSString *ste = user.type;
         NSLog(@"%@",ste);
         _pricestring = responsObject[@"price"];
         _Typetring = responsObject[@"type"];
        
         //_pricestring = [NSString stringWithFormat:@"%@%@", priceString, type];
         //NSLog(@"%@",_pricestring);
         //NSLog(@"%@",_Typetring);
         for (NSMutableDictionary *dict in dataArray) {
             priceModel *model = [priceModel initWithDict:dict];
             
             NSURL *url = [NSURL URLWithString:model.photo];
             [self.imageview sd_setImageWithURL:url];
             
         }
        
     } failure:^(AFHTTPRequestOperation * operation, NSError * error)
     {
         
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)beSpokeBtn:(id)sender {
    
    
    if ([self.priceTypeStr  isEqual: @"24"]||[self.priceTypeStr  isEqual: @"34"]||[self.priceTypeStr  isEqual: @"36"]||[self.priceTypeStr  isEqual: @"37"]) {
        HomeBeSpeakCarViewController *HSCVC = [[HomeBeSpeakCarViewController alloc ]init];
        HSCVC.typeidstring = self.priceTypeStr;
        HSCVC.priceTypestring = _pricestring;
        HSCVC.Typestring = _Typetring;
        [self.navigationController pushViewController:HSCVC animated:YES];
        
    }else{
        HomeBeSpeakViewController *HSVC = [[HomeBeSpeakViewController alloc]init];
        HSVC.typeidstring = self.priceTypeStr;
        HSVC.priceTypestring = _pricestring;
        HSVC.Typestring = _Typetring;
        [self.navigationController pushViewController:HSVC animated:YES];
    }

}
@end

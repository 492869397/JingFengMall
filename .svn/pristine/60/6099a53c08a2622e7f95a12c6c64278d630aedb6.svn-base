//
//  AddReciverViewController.h
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ConsigneeModel.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>


@interface AddReciverViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,BMKGeoCodeSearchDelegate>

@property(strong,nonatomic)ConsigneeModel *con;

@property(strong,nonatomic)BMKGeoCodeSearch *search;

@property(assign,nonatomic)BOOL addressValid;
@property(assign,nonatomic)float lat;
@property(assign,nonatomic)float lng;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *number;
@property (strong, nonatomic) IBOutlet UITextField *area;
@property (strong, nonatomic) IBOutlet UITextField *street;
@property (strong, nonatomic) IBOutlet UITextField *detailAddress;
//拼接完全的收货地址
@property(copy,nonatomic)NSString *address;

//收货地址所在城市，百度地图编码需要使用
@property(copy,nonatomic)NSString *reciveCity;

@property(strong,nonatomic)UIPickerView *picker;

@property(strong,nonatomic)NSArray *province;
@property(strong,nonatomic)NSArray *city;
@property(strong,nonatomic)NSArray *district;
- (IBAction)save:(id)sender;

@end

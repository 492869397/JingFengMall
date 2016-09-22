//
//  HomeBeSpeakViewController.h
//  JingFengMall
//
//  Created by len on 16/5/7.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>


@interface HomeBeSpeakViewController : UIViewController<BMKGeoCodeSearchDelegate,UITextFieldDelegate>

@property (nonatomic ,copy)NSString *priceTypestring;
@property (nonatomic ,copy)NSString *Typestring;
@property (nonatomic ,copy)NSString *AddressStr;
@property (nonatomic ,copy)NSString *PhoneStr;
@property (nonatomic ,copy)NSString *BeizhuStr;
@property (nonatomic ,copy)NSString *TimeStr;
@property (nonatomic ,copy)NSString *typeidstring;
@property (nonatomic ,copy)NSString *AuntID;


@end

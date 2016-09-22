//
//  SelectServicerViewController.h
//  JingFengMall
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectServicerViewController : UIViewController
@property(strong,nonatomic)NSMutableArray *array;
@property (nonatomic ,strong)NSDictionary *Dic;
@property (nonatomic ,copy)NSString *typeId;
@property (nonatomic ,copy)NSString *lblName;
@property(nonatomic,copy) void(^myselectBlock)(NSString *selectID);
@property(nonatomic,copy) void(^myselectBlockTwo)(NSString *selectNamelbl);

@end

//
//  SubDetailViewController.h
//  JingFengMall
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    SubCellHaveMoneyLabel = 0,
    SubCellNoMoneyLabel
    
}SubCellType;

@interface SubDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(assign,nonatomic)SubCellType cellType;

@property(strong,nonatomic)NSArray *array;

@end

//
//  SelectWayViewController.h
//  JingFengMall
//
//  Created by len on 16/1/28.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface SelectWayViewController : UITableViewController<BMKPoiSearchDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property(strong,nonatomic)UISearchController *searchController;

@property(strong,nonatomic)id delegate;
@property(strong,nonatomic)NSArray *poiArray;

@property(strong,nonatomic)BMKPoiSearch *search;
@property(copy,nonatomic)NSString *curCity;

@property(assign,nonatomic)NSInteger senderTag;

@end

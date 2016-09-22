//
//  SelectWayViewController.m
//  JingFengMall
//
//  Created by len on 16/1/28.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "SelectWayViewController.h"
#import "GetCarViewController.h"
#import "AppDelegate.h"

@interface SelectWayViewController ()

@end

@implementation SelectWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.showsCancelButton = YES;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.tableView.tableHeaderView = self.searchController.searchBar;
}
//隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.search = [[BMKPoiSearch alloc]init];
    self.search.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.search = nil;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return self.poiArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    BMKPoiInfo *poi = self.poiArray[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
    GetCarViewController *getCarView = (GetCarViewController*)self.delegate;
    BMKPoiInfo *poi = self.poiArray[indexPath.row];
    if (self.senderTag == 1) {
        getCarView.startPT = poi.name;
        getCarView.startLng = [NSNumber numberWithDouble:poi.pt.longitude];
        getCarView.startLat = [NSNumber numberWithDouble:poi.pt.latitude];
        getCarView.isShouldUseSelfPosition = NO;
    }
    else
    {
        getCarView.endPT = poi.name;
        getCarView.endLng = [NSNumber numberWithDouble:poi.pt.longitude];
        getCarView.endLat = [NSNumber numberWithDouble:poi.pt.latitude];
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *keyWords = self.searchController.searchBar.text;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 50;
    NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:@"curCity"];
    citySearchOption.city= city;
    citySearchOption.keyword = keyWords;
    [_search poiSearchInCity:citySearchOption];
}

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (self.search == searcher) {
        if (error == BMK_SEARCH_NO_ERROR) {
            self.poiArray = result.poiInfoList;
            [self.tableView reloadData];
        } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
            Toast *toast = [Toast makeText:@"定位失败"];
            [toast showWithType:ShortTime];
        }else if (error == BMK_SEARCH_PERMISSION_UNFINISHED){//百度地图鉴定失败 重新鉴定
            Toast *toast = [Toast makeText:@"百度地图鉴权失败"];
            [toast showWithType:ShortTime];
        }
    }
}

@end

//
//  HomeBeSpeakCarViewController.m
//  JingFengMall
//
//  Created by len on 16/6/22.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeBeSpeakCarViewController.h"
#import "CommitHouseOrderTwoViewController.h"
#import "SelectServicerViewController.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>


@interface HomeBeSpeakCarViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic,strong)UIDatePicker *UIDatePicker;
//价格
@property (strong, nonatomic) IBOutlet UILabel *Costlbl;
//类型
@property (strong, nonatomic) IBOutlet UILabel *TypelblTwo;
//属性
@property (strong, nonatomic) IBOutlet UIButton *SelectAuntBtn;
//选择服务人员事件
- (IBAction)SelectAuntBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *SelectAddressBtn;
@property (weak, nonatomic) IBOutlet UILabel *SelectAddressEndPoint;


- (IBAction)NextBtn:(id)sender;
//起点具体地址 UITextField
@property (strong, nonatomic) IBOutlet UITextField *txtAddres;
//终点具体地址 UITextField
@property (strong, nonatomic) IBOutlet UITextField *txtAddreszhingdian;
//UITextField 电话
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
//备注
@property (strong, nonatomic) IBOutlet UITextField *txtBeizhu;
//上门时间显示
@property (strong, nonatomic) IBOutlet UILabel *lblTime;


//上门时间选择
- (IBAction)SelectTimeBtn:(id)sender;

@property(copy,nonatomic)NSString *reciveCity;

@property(strong,nonatomic)UIPickerView *picker;

@property(strong,nonatomic)NSArray *province;
@property(strong,nonatomic)NSArray *city;
@property(strong,nonatomic)NSArray *district;

@property(copy,nonatomic)NSString *addressString;

@property(strong,nonatomic)BMKGeoCodeSearch *search;

@property(strong,nonatomic)BMKGeoCodeSearch *searchEndPoint;


@property(assign,nonatomic)BOOL addressValid;
@property(assign,nonatomic)float lat;
@property(assign,nonatomic)float lng;

@property(assign,nonatomic)BOOL addressEndPointValid;
@property(assign,nonatomic)float latEndPoint;
@property(assign,nonatomic)float lngEndPoint;

@property(assign,nonatomic)float distance;

@end

@implementation HomeBeSpeakCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约";
    
    self.search =[[BMKGeoCodeSearch alloc]init];
    
    self.searchEndPoint = [[BMKGeoCodeSearch alloc]init];
    
    _txtAddres.delegate = self;
    
    _txtAddreszhingdian.delegate = self;
    
    self.Costlbl.text = self.priceTypestring;
    self.TypelblTwo.text = self.Typestring;
    //NSArray *pArr =[self.priceTypestring componentsSeparatedByString:@"/"];
    //NSString *pStr1=[pArr objectAtIndex:1];
    //self.Typelbl.text = pStr1;
    
    self.addressString = [NSMutableString string];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAddress:)];
    _SelectAddressBtn.userInteractionEnabled = YES;
    [_SelectAddressBtn addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAddress:)];
//    _SelectAddressEndPoint.userInteractionEnabled = YES;
    [_SelectAddressEndPoint addGestureRecognizer:tap1];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _search.delegate = self;
    _searchEndPoint.delegate = self;
}


-(void)viewWillDisappear:(BOOL)animated
{
    _search.delegate = nil;
    _searchEndPoint.delegate = nil;
}


#pragma mark - textField delegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if (textField == _txtAddreszhingdian) {
        
        BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];

        geoCodeSearchOption.city= _SelectAddressEndPoint.text;
        
        geoCodeSearchOption.address = _txtAddreszhingdian.text;
        
        [_searchEndPoint geoCode:geoCodeSearchOption];
    
        
    }else
    {
        BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];

        geoCodeSearchOption.city= _SelectAddressBtn.text;
        
        geoCodeSearchOption.address = _txtAddres.text;
        
        [_search geoCode:geoCodeSearchOption];

    }
    
}

#pragma mark - 百度地图地址编码
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    
    
    if (searcher == _search) {
        if (error == BMK_SEARCH_NO_ERROR) {
            _lat = result.location.latitude;
            _lng = result.location.longitude;
            
            _addressValid = YES;
        }
        else {
            Toast *toa = [Toast makeText:@"起点地址输入有误"];
            [toa showWithType:ShortTime];
            _addressValid = NO;
        }
    }else
    {
        
        if (error == BMK_SEARCH_NO_ERROR) {
            _latEndPoint = result.location.latitude;
            _lngEndPoint = result.location.longitude;
            
            _addressEndPointValid = YES;
        }
        else {
            Toast *toa = [Toast makeText:@"终点地址输入有误"];
            [toa showWithType:ShortTime];
            
            _addressEndPointValid = NO;
        }
    }
    
#pragma mark - 计算两点间距离
    if (_addressValid && _addressEndPointValid) {
        BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(_lat,_lng));
        BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(_latEndPoint,_lngEndPoint));
        //单位M
        CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
        
        //单位KM
        _distance = distance/1000;
    }
    
}

- (void)dateChange:(id )sender{
    //取出日期
    NSDate *select = [_UIDatePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateAndTime =  [dateFormatter stringFromDate:select];
    self.lblTime.text = dateAndTime;
    _TimeStr = dateAndTime;
    
    [[[[sender superview] superview] superview]removeFromSuperview];
    
    
}


- (void)buttonAction{

    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, SCREEN_HEIGHT)];
    v.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    self.UIDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 60, kMainScreenWidth, 190)];
    //    _UIDatePicker.backgroundColor = [UIColor lightGrayColor];
    _UIDatePicker.hidden = NO;
    [_UIDatePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [_UIDatePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, kMainScreenHeight-300+80, kMainScreenWidth, 300)];
    view1.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:_UIDatePicker];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
    view2.backgroundColor = [UIColor lightGrayColor];
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(dataPickerCancel:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *comfirm = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth - 10 -40, 5, 40, 40)];
    [comfirm setTitle:@"确定" forState:UIControlStateNormal];
    [comfirm addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventTouchUpInside];
    
    [view2 addSubview:cancel];
    [view2 addSubview:comfirm];
    
    
    [view1 addSubview:view2];
    
    [v addSubview:view1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removePicker:)];
    [v addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    
}

-(void)dataPickerCancel:(id)sender
{
    [[[[sender superview] superview] superview]removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)SelectAuntBtn:(id)sender {
    SelectServicerViewController *SSVC = [[SelectServicerViewController alloc]init];
    SSVC.myselectBlock=^(NSString *selectID){
        _AuntID = selectID;
    };
    SSVC.myselectBlockTwo =^(NSString *selectNamelbl){
        _SelectAuntBtn.titleLabel.text = selectNamelbl;
    };
    SSVC.typeId = self.typeidstring;
    // NSLog(@"w=%@",self.typeidstring);
    [self.navigationController pushViewController:SSVC animated:YES];
    
}

-(void)selectAddress:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
    
    [self selectArea:tap.view];
}

-(void)setPickerViewData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"plist"];
    NSArray *array = [[NSDictionary dictionaryWithContentsOfFile:path]objectForKey:@"address"];
    self.province = array;
    self.city = [[_province objectAtIndex:0]objectForKey:@"sub"];
    self.district = [[_city objectAtIndex:0]objectForKey:@"sub"];
}

-(void)selectArea:(UIView*)label
{
    [self setPickerViewData];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, SCREEN_HEIGHT)];
    v.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    self.picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 60, kMainScreenWidth, 190)];
    _picker.delegate = self;
    _picker.dataSource = self;
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, kMainScreenHeight-300+80, kMainScreenWidth, 300)];
    view1.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:_picker];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
    view2.backgroundColor = [UIColor lightGrayColor];
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *comfirm = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth - 10 -40, 5, 40, 40)];
    [comfirm setTitle:@"确定" forState:UIControlStateNormal];
    
    comfirm.tag = label.tag;
    
    [comfirm addTarget:self action:@selector(comfirm:) forControlEvents:UIControlEventTouchUpInside];
    
    [view2 addSubview:cancel];
    [view2 addSubview:comfirm];
    
    
    [view1 addSubview:view2];
    
    [v addSubview:view1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removePicker:)];
    [v addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    
}

-(void)removePicker:(UITapGestureRecognizer*)tap
{
    [tap.view removeFromSuperview];
}

-(void)cancel:(UIButton*)sender
{
    [[[[sender superview] superview] superview]removeFromSuperview];
}

-(void)comfirm:(UIButton*)sender
{
    
    if (_district.count > 0) {
        _addressString = [NSString stringWithFormat:@"%@%@%@",[[_province objectAtIndex:[_picker selectedRowInComponent:0]]objectForKey:@"name"],[[_city objectAtIndex:[_picker selectedRowInComponent:1]]objectForKey:@"name"],[_district objectAtIndex:[_picker selectedRowInComponent:2]]];
        
        
        
    }else
    {
        _addressString = [NSString stringWithFormat:@"%@%@",[[_province objectAtIndex:[_picker selectedRowInComponent:0]]objectForKey:@"name"],[[_city objectAtIndex:[_picker selectedRowInComponent:1]]objectForKey:@"name"]];
        
    }
    
    
    self.reciveCity = [[_city objectAtIndex:[_picker selectedRowInComponent:1]]objectForKey:@"name"];
    
    
    if (sender.tag == 1) {
        _SelectAddressBtn.text = [NSString stringWithString:_addressString];

    }else if(sender.tag == 2)
    {
        _SelectAddressEndPoint.text = [NSString stringWithString:_addressString];
    }
    
    [[[[sender superview] superview] superview ] removeFromSuperview];
}
#pragma pickerView代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _province.count;
    }else if (component == 1)
    {
        return _city.count;
    }
    else
    {
        return _district.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [[_province objectAtIndex:row]objectForKey:@"name"];
    }else if (component == 1)
    {
        return [[_city objectAtIndex:row]objectForKey:@"name"];
    }
    return [_district objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.city = [[_province objectAtIndex:row]objectForKey:@"sub"];
        self.district = [[_city objectAtIndex:0]objectForKey:@"sub"];
        [self.picker reloadComponent:1];
        [self.picker reloadComponent:2];
        
    }else if (component == 1)
    {
        self.district = [[_city objectAtIndex:row]objectForKey:@"sub"];
        [self.picker reloadComponent:2];
        
    }
}


- (IBAction)SelectTimeBtn:(id)sender {
    [self buttonAction];
}

- (IBAction)NextBtn:(id)sender {
    
    if (self.AuntID==nil) {
        Toast *toast = [Toast makeText:@"请选择雇员"];
        [toast showWithType:ShortTime];
        return;
    }
    
    if ([self.txtAddres.text isEqualToString:@""]) {
        Toast *toast = [Toast makeText:@"请填写具体地址"];
        [toast showWithType:ShortTime];
        return;
    }
    
    if ([self.SelectAddressBtn.text isEqualToString:@"选择起点"]) {
        Toast *toast = [Toast makeText:@"请选择起点地址"];
        [toast showWithType:ShortTime];
        return;
    }
    
    if ([self.SelectAddressEndPoint.text isEqualToString:@"选择终点"]) {
        Toast *toast = [Toast makeText:@"请选择终点地址"];
        [toast showWithType:ShortTime];
        return;
    }
    
    if (!_addressValid) {
        Toast *toast = [Toast makeText:@"起点地址有误"];
        [toast showWithType:ShortTime];
        return;
    }
    
    if (!_addressEndPointValid) {
        Toast *toast = [Toast makeText:@"终点地址有误"];
        [toast showWithType:ShortTime];
        return;
    }
    
    if ([self.lblTime.text isEqualToString:@""]) {
        Toast *toast = [Toast makeText:@"请选择时间"];
        [toast showWithType:ShortTime];
        return;
    }
    
    if ([self.txtPhone.text isEqualToString:@""]) {
        
        Toast *toast = [Toast makeText:@"请填写手机号"];
        [toast showWithType:ShortTime];
        return;
    }
    
    CommitHouseOrderTwoViewController *CHOVC = [[CommitHouseOrderTwoViewController alloc]init];
    
    CHOVC.distance = _distance;
    
    CHOVC.strTwo = self.txtPhone.text;
    CHOVC.strThree =  self.txtBeizhu.text;
    CHOVC.strTimeTwo = self.lblTime.text;
    CHOVC.strTypeID = self.typeidstring;
    CHOVC.AuntID = self.AuntID;
    
    NSString *addressEndPoint = [NSString stringWithFormat:@"%@%@",_SelectAddressEndPoint.text,_txtAddreszhingdian.text];
    CHOVC.endPoint = addressEndPoint;
    CHOVC.latEndPoint = _latEndPoint;
    CHOVC.lngEndPoint = _lngEndPoint;
    
    NSString *address = [NSString stringWithFormat:@"%@%@",_SelectAddressBtn.text,_txtAddres.text];
    CHOVC.startPoint = address;
    CHOVC.lat = _lat;
    CHOVC.lng = _lng;
    
    
    
    
    [self.navigationController pushViewController:CHOVC animated:YES];
    self.SelectAuntBtn.selected = NO;
    
    
    
}
@end

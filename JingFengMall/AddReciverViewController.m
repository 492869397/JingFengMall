//
//  AddReciverViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "AddReciverViewController.h"

@interface AddReciverViewController ()

@end

@implementation AddReciverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建收货人";
    
    [self setSubView];
    [self setPickerViewData];
    _search =[[BMKGeoCodeSearch alloc]init];
}

-(void)setSubView
{
    _area.delegate = self;
    
    if (self.con) {
        _name.text = _con.consignee;
        _number.text = _con.userPhone;
        _area.text = _con.localtion;
        _street.text = _con.street;
        _detailAddress.text = _con.detailAddress;
    }
    
    _name.leftViewMode = UITextFieldViewModeAlways;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"   收货人:  ";
    [label sizeToFit];
    _name.leftView = label;
    
    _number.leftViewMode = UITextFieldViewModeAlways;
    label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"   联系方式:  ";
    [label sizeToFit];
    _number.leftView = label;
    
    _area.leftViewMode = UITextFieldViewModeAlways;
    label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"   所在地区:  ";
    [label sizeToFit];
    label.adjustsFontSizeToFitWidth = YES;
    _area.leftView = label;
    
    _street.leftViewMode = UITextFieldViewModeAlways;
    label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"   街道:  ";
    [label sizeToFit];
    _street.leftView = label;
    
    _detailAddress.leftViewMode = UITextFieldViewModeAlways;
    label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"   详细地址:  ";
    [label sizeToFit];
    label.adjustsFontSizeToFitWidth = YES;
    _detailAddress.leftView = label;
    
}

-(void)setPickerViewData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"plist"];
    NSArray *array = [[NSDictionary dictionaryWithContentsOfFile:path]objectForKey:@"address"];
    self.province = array;
    self.city = [[_province objectAtIndex:0]objectForKey:@"sub"];
    self.district = [[_city objectAtIndex:0]objectForKey:@"sub"];
}


-(void)viewWillAppear:(BOOL)animated
{
    _search.delegate = self;
}


-(void)viewWillDisappear:(BOOL)animated
{
    _search.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 百度地图位置编码

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        
        _lat = result.location.latitude;
        _lng = result.location.longitude;
        
        _addressValid = YES;
    }
    else {
        Toast *toa = [Toast makeText:@"地址输入有误，请检查"];
        [toa showWithType:ShortTime];
        _addressValid = NO;
    }
}






#pragma textfild代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_area == textField) {
        [self.view endEditing:YES];
        
        [self selectArea];
        
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.address = [NSString stringWithFormat:@"%@%@%@",_area.text,_street.text,_detailAddress.text];
    
    if ([self isShouldReverCodeLocation]) {
        
        BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geoCodeSearchOption.city= _reciveCity;
        
        NSArray *arr = [_address componentsSeparatedByString:_reciveCity];
        geoCodeSearchOption.address = [arr lastObject];
        [_search geoCode:geoCodeSearchOption];
        
    }
}

-(void)selectArea
{
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
        _address = [NSString stringWithFormat:@"%@%@%@",[[_province objectAtIndex:[_picker selectedRowInComponent:0]]objectForKey:@"name"],[[_city objectAtIndex:[_picker selectedRowInComponent:1]]objectForKey:@"name"],[_district objectAtIndex:[_picker selectedRowInComponent:2]]];
        
        
        
    }else
    {
        self.address = [NSString stringWithFormat:@"%@%@",[[_province objectAtIndex:[_picker selectedRowInComponent:0]]objectForKey:@"name"],[[_city objectAtIndex:[_picker selectedRowInComponent:1]]objectForKey:@"name"]];
        
    }
    
    
    self.reciveCity = [[_city objectAtIndex:[_picker selectedRowInComponent:1]]objectForKey:@"name"];
    
    _area.text = _address;
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

- (IBAction)save:(id)sender {
    
    if (![self isMsgFilledOut]) {
        return;
    }
    
    
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    [pass setObject:_name.text forKey:@"consignee"];
    [pass setObject:_number.text forKey:@"consigneePhone"];
    [pass setObject:_area.text forKey:@"localtion"];
    [pass setObject:_street.text forKey:@"street"];
    [pass setObject:_detailAddress.text forKey:@"detailedAddress"];
    [pass setObject:[NSNumber numberWithFloat:_lat] forKey:@"lat"];
    [pass setObject:[NSNumber numberWithFloat:_lng] forKey:@"lng"];
    
    
    
    if (self.con) {
        [pass setObject:_con.Id forKey:@"id"];
    }
    
    
    Network *net = [[Network alloc]init];
    
    NSString *url = self.con == nil?@"http://123.57.28.11:8080/jfsc_app/addAddress.do":@"http://123.57.28.11:8080/jfsc_app/updateAddress.do";
    
    [net accessNetUrl:url parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            NSString *msg = [responseObject objectForKey:@"msg"];
            Toast *toa = [Toast makeText:msg];
            [toa showWithType:ShortTime];
        }
    }];

}

-(BOOL)isMsgFilledOut
{
    BOOL a,b,c,d,e;
    a = self.name.text.length > 0;
    b = self.number.text.length > 10;
    c = self.area.text.length > 0 ;
    d = self.street.text.length > 0 ;
    e = self.detailAddress.text > 0 ;
    
    
    
    if (!(a && b && c && d && e)) {
        
        Toast *toa = [Toast makeText:@"请填写完整信息"];
        [toa showWithType:ShortTime];
        
    }else if(!_addressValid)
    {
        Toast *toa = [Toast makeText:@"地址信息输入有误"];
        [toa showWithType:ShortTime];
    }
    
    return a && b && c && d && e && _addressValid;
}

-(BOOL)isShouldReverCodeLocation
{
    BOOL a,b,c;
    a = self.area.text.length > 0 ;
    b = self.street.text.length > 0 ;
    c = self.detailAddress.text > 0 ;
    
    return a && b && c ;
}

@end
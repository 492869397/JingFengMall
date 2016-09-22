//
//  HomeBeSpeakViewController.m
//  JingFengMall
//
//  Created by len on 16/5/7.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeBeSpeakViewController.h"
#import "SelectServicerViewController.h"
#import "CommitHouseOrderViewController.h"


@interface HomeBeSpeakViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)UIDatePicker *UIDatePicker;
@property (strong, nonatomic) IBOutlet UILabel *Costlbl;
@property (strong, nonatomic) IBOutlet UILabel *Typelbl;
@property (strong, nonatomic) IBOutlet UILabel *TypelblTwo;
@property (strong, nonatomic) IBOutlet UIButton *SelectAuntBtn;
@property (strong, nonatomic) IBOutlet UILabel *fuwuType;
- (IBAction)SelectAuntBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *SelectAddressBtn;
- (IBAction)SelectTimeBtn:(id)sender;
- (IBAction)NextBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtAddres;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtBeizhu;
- (IBAction)UpDownBtn:(id)sender;
- (IBAction)addBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtShowNum;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;


@property(copy,nonatomic)NSString *reciveCity;

@property(strong,nonatomic)UIPickerView *picker;

@property(strong,nonatomic)NSArray *province;
@property(strong,nonatomic)NSArray *city;
@property(strong,nonatomic)NSArray *district;

@property(copy,nonatomic)NSString *addressString;

@property(strong,nonatomic)BMKGeoCodeSearch *search;


@property(assign,nonatomic)BOOL addressValid;
@property(assign,nonatomic)float lat;
@property(assign,nonatomic)float lng;
@end

@implementation HomeBeSpeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约";
    
    _search =[[BMKGeoCodeSearch alloc]init];

    _txtAddres.delegate = self;
    
    self.Costlbl.text = self.priceTypestring;
    self.TypelblTwo.text = self.Typestring;
    NSArray *pArr =[self.priceTypestring componentsSeparatedByString:@"/"];
    NSString *pStr1=[pArr objectAtIndex:1];
    self.Typelbl.text = pStr1;

    self.addressString = [NSMutableString string];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAddress:)];
    _SelectAddressBtn.userInteractionEnabled = YES;
    [_SelectAddressBtn addGestureRecognizer:tap];

    [self setLabel];
}

-(void)setLabel
{
    if([self.Typelbl.text isEqualToString:@"次"]){
        self.fuwuType.text = @"服务次数";
    }
    else if ([self.Typelbl.text isEqualToString:@"平米"]){
        self.fuwuType.text = @"清理面积";
    }
    else{
        self.fuwuType.text = @"服务时间";
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    _search.delegate = self;
}


-(void)viewWillDisappear:(BOOL)animated
{
    _search.delegate = nil;
}


#pragma mark - textField delegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _txtAddres) {
        BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geoCodeSearchOption.city= _SelectAddressBtn.text;
        
        geoCodeSearchOption.address = self.txtAddres.text;
        
        [_search geoCode:geoCodeSearchOption];
    }
    if (textField == _txtShowNum) {
        if (textField.text.integerValue == 0 || [textField.text isEqualToString:@""]) {
            Toast *toa = [Toast makeText:@"请输入正确的数字"];
            [toa showWithType:ShortTime];
            textField.text = @"1";
        }else
        {
            textField.text = [NSString stringWithFormat:@"%ld",(long)textField.text.integerValue];
        }
    }
}

#pragma mark - 百度地图地址编码
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
//    _UIDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(10, 300, SCREEN_WIDTH -20, 260)];
//    _UIDatePicker.backgroundColor = [UIColor lightGrayColor]; 
//    _UIDatePicker.hidden = NO;
//    [_UIDatePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
//    [_UIDatePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:_UIDatePicker];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



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
////城市三级联动
//- (IBAction)SelectAddressBtn:(id)sender {
//    [self.view endEditing:YES];
//    [self selectArea];
//}
-(void)selectAddress:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
    [self selectArea];
}

-(void)setPickerViewData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"plist"];
    NSArray *array = [[NSDictionary dictionaryWithContentsOfFile:path]objectForKey:@"address"];
    self.province = array;
    self.city = [[_province objectAtIndex:0]objectForKey:@"sub"];
    self.district = [[_city objectAtIndex:0]objectForKey:@"sub"];
}

-(void)selectArea
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
    
    _SelectAddressBtn.text = [NSString stringWithString:_addressString];
    
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
    
    if ([self.SelectAddressBtn.text isEqualToString:@"选择地址"]) {
        Toast *toast = [Toast makeText:@"请选择地址"];
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
    
    CommitHouseOrderViewController *CHOVC = [[CommitHouseOrderViewController alloc]init];
    CHOVC.strTime = self.txtShowNum.text;
    
    NSString *address = [NSString stringWithFormat:@"%@%@",_SelectAddressBtn.text,self.txtAddres.text];
    CHOVC.strOne = address;
    CHOVC.strTwo = self.txtPhone.text;
    CHOVC.strThree =  self.txtBeizhu.text;
    CHOVC.strTimeTwo = self.lblTime.text;
    CHOVC.strTypeID = self.typeidstring;
    CHOVC.AuntID = self.AuntID;
    CHOVC.lat = _lat;
    CHOVC.lng = _lng;
    [self.navigationController pushViewController:CHOVC animated:YES];
    self.SelectAuntBtn.selected = NO;

    

}

//- (BOOL)checkMobileNumber {
//
//    if (self.length > 11 || self.length == 0) {
//        return false;
//    }
//
//    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isValid = [predicate evaluateWithObject:self];
//    
//    //匹配对的是返回true
//    return isValid;
//}


- (IBAction)UpDownBtn:(id)sender {
    
    NSInteger num = _txtShowNum.text.integerValue;
    if (num >1) {
        _txtShowNum.text = [NSString stringWithFormat:@"%ld",(long)num-1];
    }
}

- (IBAction)addBtn:(id)sender {
    
    NSInteger num = _txtShowNum.text.integerValue;
    _txtShowNum.text = [NSString stringWithFormat:@"%ld",(long)num+1];
//   _goods.goodsNumber = [NSNumber numberWithInteger:[_lblShowNum.text integerValue]];

}
@end
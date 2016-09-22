//
//  AcconutTableViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "AcconutTableViewController.h"
#import "ChangeNameViewController.h"
#import "AddressTableViewController.h"
#import "AccountSafeViewController.h"
#import "SexTableViewController.h"
#import "RDVTabBarController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

@interface AcconutTableViewController ()

@property(strong,nonatomic)MBProgressHUD *HUD;

@end

@implementation AcconutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的账户";
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self setData];
}

-(void)setData
{
    self.titleArray = @[@"头像",@"用户名",@"昵称",@"性别",@"出生日期",@"地址管理",@"账户安全"];
    
    
    self.detailArray = [NSMutableArray array];
    [_detailArray addObject:@""];
    [_detailArray addObject:@""];
    [_detailArray addObject:@""];
    [_detailArray addObject:@""];
    [_detailArray addObject:@""];
    [_detailArray addObject:@""];
    [_detailArray addObject:@""];
    

}

-(void)initNetData
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/selectUserByUserPhone.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            NSDictionary *dic = [[responseObject objectForKey:@"list"]firstObject];
            
            [_detailArray removeAllObjects];
            
            [[dic objectForKey:@"photoPath"] isKindOfClass:[NSNull class]]?[_detailArray addObject:@""]:[_detailArray addObject:[dic objectForKey:@"photoPath"]];
            
            [[dic objectForKey:@"userName"] isKindOfClass:[NSNull class]]?[_detailArray addObject:@""]:[_detailArray addObject:[dic objectForKey:@"userName"]];
            
            [[dic objectForKey:@"nickName"] isKindOfClass:[NSNull class]]?[_detailArray addObject:@""]:[_detailArray addObject:[dic objectForKey:@"nickName"]];
            
            [[dic objectForKey:@"sex"] isKindOfClass:[NSNull class]]?[_detailArray addObject:@""]:[_detailArray addObject:[dic objectForKey:@"sex"]];
            
            if ([[dic objectForKey:@"birthday"] isKindOfClass:[NSNull class]]) {
                
                [_detailArray addObject:@""];
                
            }else
            {
                NSTimeInterval time = [(NSNumber*)[dic objectForKey:@"birthday"] doubleValue]/1000;
                NSDateFormatter *format = [[NSDateFormatter alloc]init];
                format.dateFormat = @"yyyy年MM月dd日";
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                [_detailArray addObject:[format stringFromDate:date]];
            }
            
            
            [_detailArray addObject:@""];
            [_detailArray addObject:@""];
            
            [self.tableView reloadData];
            
        }
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [self initNetData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cell1 = @"cell1";
    NSString *cell2 = @"cell2";
    NSString *cell3 = @"cell3";
    
    UITableViewCell *cell;
    if ( indexPath.row == 0 && indexPath.section == 0) {
         cell = [tableView dequeueReusableCellWithIdentifier:cell1];
    }else if (indexPath.row ==1 && indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cell2];
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cell3];
    }
    
    if(!cell){
        if ( indexPath.row == 0 && indexPath.section == 0) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell1];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
        }else if (indexPath.row ==1 && indexPath.section == 0){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell2];
        }else
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell3];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    cell.textLabel.text = _titleArray[indexPath.row+5*indexPath.section];
    
    if (indexPath.row != 0 || indexPath.section != 0) {
        cell.detailTextLabel.text = _detailArray[indexPath.row+5*indexPath.section];
    }else
    {
        UIImageView *sw = [[UIImageView alloc]initWithFrame:CGRectMake(kMainScreenWidth-80, 2, 40, 40)];
        
        sw.layer.cornerRadius = 20;
        sw.layer.borderWidth = 1;
        sw.clipsToBounds = YES;
        
        NSString *url = [_detailArray[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [sw sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        
        [cell.contentView addSubview:sw];

    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 )
    {
        switch (indexPath.row) {
            case 0:
                [self selectPhotoSouceType];
                break;
            case 2:
                [self changeName];
                break;
            case 3:
                [self selectSex];
                break;
            case 4:
                [self selectBirthday];
                break;
            default:
                break;
        }
    }else
    {
        if (indexPath.row == 0) {
            [self placeManage];
        }else
        {
            [self accountSafe];
        }
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.0];
        
        UIButton *loginOut = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, SCREEN_WIDTH - 60, 40)];
        loginOut.backgroundColor = [UIColor redColor];
        loginOut.layer.cornerRadius = 5 ;
        [loginOut addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
        [loginOut setTitle:@"退出登录" forState:(UIControlStateNormal)];
        
        [view addSubview:loginOut];
        
        return view;
    }
    return nil;
    
}

#pragma mark - 更换头像
-(void)selectPhotoSouceType
{
    UIActionSheet *photoPath = [[UIActionSheet alloc]initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"相机", nil];
    [photoPath showInView:self.view];
}

-(void)changeName
{
    ChangeNameViewController *view = [[ChangeNameViewController alloc]init];
    view.name.text = _detailArray[2];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)selectSex
{
    SexTableViewController *vc = [[SexTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 选择出生年月
-(void)selectBirthday
{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, SCREEN_HEIGHT)];
    v.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    self.picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 60, kMainScreenWidth, 190)];
    _picker.datePickerMode = UIDatePickerModeDate;
    
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeDataPicker:)];
    [v addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication].keyWindow addSubview:v];
}

#pragma mark - 出生日期页面的按钮方法等
-(void)removeDataPicker:(UITapGestureRecognizer*)tap
{
    [tap.view removeFromSuperview];
}

-(void)cancel:(UIButton*)sender
{
    [[[[sender superview] superview] superview]removeFromSuperview];
}

-(void)comfirm:(UIButton*)sender
{
    NSDate *date = _picker.date;
    NSTimeInterval birth = [date timeIntervalSince1970]*1000;
    
    Network *net = [[Network alloc]init];
    
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setObject:user forKey:@"userPhone"];
    [pass setObject:[NSNumber numberWithDouble:birth] forKey:@"birthday"];

    
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/updateBirthday.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            [[[[sender superview] superview] superview ] removeFromSuperview];
            
            Toast *toa = [Toast makeText:@"出生日期修改成功"];
            [toa showWithType:ShortTime];
            
            [self initNetData];
            
        }else
        {
            Toast *toa = [Toast makeText:@"修改失败"];
            [toa showWithType:ShortTime];
        }
    }];
    
}


#pragma mark - 地址管理页面
-(void)placeManage
{
    AddressTableViewController *view = [[AddressTableViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)accountSafe
{
    AccountSafeViewController *view = [[AccountSafeViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}



#pragma mark - actionSheet代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self enterPhotoLib];
            break;
        case 1:
            [self enterCamera];
            break;
        default:
            break;
    }
}

-(void)enterPhotoLib
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];;
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        Toast *toa = [Toast makeText:@"没有权限进入相册"];
        [toa showWithType:ShortTime];
    }
}

-(void)enterCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];;
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        Toast *toa = [Toast makeText:@"没有权限进入相机"];
        [toa showWithType:ShortTime];
    }
}

#pragma mark - 代理方法 选中图片后将对图片进行操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.label.text = @"Loading";
    [_HUD showAnimated:YES];
    
    
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:2];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    [[AFHTTPSessionManager manager] POST:@"http://123.57.28.11:8080/jfsc_app/upUserChart.do" parameters:pass constructingBodyWithBlock:^(id<AFMultipartFormData> formdata) {
        [formdata appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:@"touxiang.png" mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask * ta, id responseObject) {
        
        [_HUD hideAnimated:NO];

        
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
            
            [self initNetData];
            
        }else{
            Toast *toast = [Toast makeText:@"修改失败，请重试"];
            [toast showWithType:ShortTime];
        }
        
        
    } failure:^(NSURLSessionDataTask * ta, NSError * error) {
        [_HUD hideAnimated:NO];

        
        Toast *toast = [Toast makeText:@"网络连接失败,请稍后重试"];
        [toast showWithType:ShortTime];
    }];

}


#pragma mark - 退出登录
-(void)loginOut:(UIButton*)sender
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:NO forKey:@"isUserLogin"];
    [user removeObjectForKey:ACCOUNT];
    [user removeObjectForKey:PASSWORD];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
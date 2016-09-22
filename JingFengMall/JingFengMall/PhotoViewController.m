//
//  PhotoViewController.m
//  JingFengMall
//
//  Created by len on 16/1/25.
//  Copyright (c) 2016年 JingFeng. All rights reserved.
//

#import "PhotoViewController.h"
#import "ExamineViewController.h"
#import "Network.h"
#import "AFNetworking.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传照片";
    
    self.plachImage = self.photo.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)selectPhoto:(id)sender {
    [self selectPhotoSouceType];
}

- (IBAction)confirm:(id)sender {
    if ([self isPhotoSelect]) {
        [self enterNext];
    }else
    {
        Toast *toast = [Toast makeText:@"请选择照片"];
        [toast showWithType:ShortTime];
    }
}

-(BOOL)isPhotoSelect
{
    NSData *data1 = UIImagePNGRepresentation(self.plachImage);
    NSData *data = UIImagePNGRepresentation(self.photo.image);
    if ([data isEqual:data1]) {
        return NO;
    }
    return YES;
}

//进行网络注册访问,成功即进入下一页
-(void)enterNext
{
    UIButton *button = [self.view viewWithTag:50];
    [button setEnabled:NO];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [activity setCenter:CGPointMake(kMainScreenWidth/2.0, kMainScreenHeight/2.0)];//指定进度轮中心点
    
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
    [self.view addSubview:activity];
    [activity startAnimating];
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:ACCOUNT];
    NSData *a = UIImagePNGRepresentation(self.photo.image);
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    [pass setObject:name forKey:ACCOUNT];
    [[AFHTTPSessionManager manager] POST:URL_DIVERPHOTO parameters:pass constructingBodyWithBlock:^(id<AFMultipartFormData> formdata) {
        [formdata appendPartWithFileData:a name:PHOTO fileName:@"bbb.png" mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask * ta, id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
            ExamineViewController *examine = [[ExamineViewController alloc]init];
            [self.navigationController pushViewController:examine animated:YES];
        }else{
            Toast *toast = [Toast makeText:@"注册失败,请重试"];
            [toast showWithType:ShortTime];
        }
        
        [activity stopAnimating];
        [activity removeFromSuperview];
        UIButton *button = [self.view viewWithTag:50];
        [button setEnabled:YES];
        
    } failure:^(NSURLSessionDataTask * ta, NSError * error) {
        [activity stopAnimating];
        [activity removeFromSuperview];
        UIButton *button = [self.view viewWithTag:50];
        [button setEnabled:YES];
        
        Toast *toast = [Toast makeText:@"网络连接失败,请稍后重试"];
        [toast showWithType:ShortTime];
    }];
}

#pragma 访问本地相册
//actionSheet
-(void)selectPhotoSouceType
{
    UIActionSheet *photoPath = [[UIActionSheet alloc]initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"相机", nil];
    [photoPath showInView:self.view];
}
#pragma actionSheet代理方法
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
    }
}

#pragma 代理方法 选中图片后将对图片进行操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.photo.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end

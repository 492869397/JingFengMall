//
//  ReturnGoodsViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "ReturnGoodsViewController.h"
#import "MBProgressHUD.h"

@interface ReturnGoodsViewController ()

@property(strong,nonatomic)MBProgressHUD *HUD;

@end

@implementation ReturnGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退换货申请";
    
    self.imageArray = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, _textView.frame.size.width-10, 0)];//添加一个占位label
    _placeholderLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _placeholderLabel.text = @"请输入退货理由";
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    
    _placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
    
    [_placeholderLabel sizeToFit];
    
    [self.textView addSubview:_placeholderLabel];
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 1.5;
    self.textView.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self.textView];
    
}

- (void)textDidChange {
    
    if ([self.textView.text isEqualToString:@""]) {
        
        self.placeholderLabel.hidden = NO;
    }
    else
    {
        self.placeholderLabel.hidden = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectPhoto:(id)sender {
    [self selectPhotoSouceType];
}


- (IBAction)comfirm:(UIButton *)sender {
    
    if ([self.textView.text isEqualToString:@""]) {
        Toast *toa = [Toast makeText:@"请填写退货原因"];
        [toa showWithType:ShortTime];
    }else
    {
        NSMutableDictionary *pass = [NSMutableDictionary dictionary];
        [pass setObject:_commodityid forKey:@"orderID"];
        NSLog(@"%@",_commodityid);
        [pass setObject:_textView.text forKey:@"reason"];
        if (_imageArray.count <= 0) {
            Network *net = [[Network alloc]init];
            [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/insertAuditOrder.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    Toast *toa = [Toast makeText:@"退货信息提交成功，请等待系统确认"];
                    [toa showWithType:ShortTime];
                    
                }else
                {
                    Toast *toa = [Toast makeText:@"退货信息提交失败，请重试"];
                    [toa showWithType:ShortTime];
                }
                
            }];
        }else
        {
            _HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:_HUD];
            _HUD.mode = MBProgressHUDModeIndeterminate;
            _HUD.label.text = @"Loading";
            [_HUD showAnimated:YES];
            
           
            UIImageView *imageView = _imageArray[0];
            
            NSData *a = UIImagePNGRepresentation(imageView.image);
            
            [[AFHTTPSessionManager manager] POST:@"http://123.57.28.11:8080/jfsc_app/insertAuditOrderByPhoto.do" parameters:pass constructingBodyWithBlock:^(id<AFMultipartFormData> formdata) {
                [formdata appendPartWithFileData:a name:PHOTO fileName:@"bbb.png" mimeType:@"image/png"];
            } success:^(NSURLSessionDataTask * ta, id responseObject) {
                
                [_HUD hideAnimated:NO];

                
                if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    Toast *toa = [Toast makeText:@"退货信息提交成功，请等待系统确认"];
                    [toa showWithType:ShortTime];
                    
                }else{
                    Toast *toa = [Toast makeText:@"退货信息提交失败，请重试"];
                    [toa showWithType:ShortTime];
                }
                
                
                UIButton *button = [self.view viewWithTag:50];
                [button setEnabled:YES];
                
            } failure:^(NSURLSessionDataTask * ta, NSError * error) {
                
                [_HUD hideAnimated:NO];

                UIButton *button = [self.view viewWithTag:50];
                [button setEnabled:YES];
                
                Toast *toast = [Toast makeText:@"网络连接失败,请稍后重试"];
                [toast showWithType:ShortTime];
            }];

        }
    }
    
    
}



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

#pragma 代理方法 选中图片后将对图片进行操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 100, 100)];
    imageView.image = image;
    [self.viewForPhoto addSubview:imageView];
    
    [_imageArray addObject:imageView];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end

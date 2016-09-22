//
//  CommentGoodsViewController.m
//  JingFengMall
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CommentGoodsViewController.h"
#import "MBProgressHUD.h"

@interface CommentGoodsViewController ()

@property(strong,nonatomic)MBProgressHUD *HUD;

@end

@implementation CommentGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评价";

    _comment.layer.borderWidth = 2;
    _comment.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
    _comment.layer.cornerRadius = 8;
    
    self.imageArray = [NSMutableArray array];
    
    _commentLevel = @"5";
    _startView.delegate = self;
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    int s = score * 5;
    _commentLevel = [NSString stringWithFormat:@"%d",s];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)selectPhoto:(id)sender {
    [self selectPhotoSouceType];
}


- (IBAction)comfirm:(UIButton *)sender {
    
    if ([self.comment.text isEqualToString:@""]) {
        Toast *toa = [Toast makeText:@"请填写评价内容"];
        [toa showWithType:ShortTime];
    }else
    {
        
//        NSArray *commodityID = [_order.commodityNumber componentsSeparatedByString:@","];
//        NSMutableString *ID = [NSMutableString string];
//        
//        for (int i = 0; i < commodityID.count; i += 2) {
//            
//            if (i == 0) {
//                [ID appendString:commodityID[i]];
//            }else
//            {
//                [ID appendFormat:@",%@",commodityID[i]];
//            }
//            
//        }
        
        NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"];
        
        NSMutableDictionary *pass = [NSMutableDictionary dictionary];
        [pass setObject:phone forKey:@"userPhone"];
//        [pass setObject:ID forKey:@"commodityID"];
        [pass setObject:_order.commodityid forKey:@"orderID"];
        [pass setObject:_comment.text forKey:@"assess"];
        [pass setObject:_commentLevel forKey:@"assessType"];
        
        if (_imageArray.count <= 0) {
            Network *net = [[Network alloc]init];
            [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/addMallAssess.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    Toast *toa = [Toast makeText:@"评价成功"];
                    [toa showWithType:ShortTime];
                    
                }else
                {
                    Toast *toa = [Toast makeText:@"评价信息提交失败，请重试"];
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
            
            [[AFHTTPSessionManager manager] POST:@"http://123.57.28.11:8080/jfsc_app/addMallAssessAndPhoto.do" parameters:pass constructingBodyWithBlock:^(id<AFMultipartFormData> formdata) {
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
    [_viewForPhoto addSubview:imageView];
    
    [_imageArray addObject:imageView];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end

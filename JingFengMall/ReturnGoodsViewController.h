//
//  ReturnGoodsViewController.h
//  JingFengMall
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReturnGoodsViewController : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(copy,nonatomic)NSString *commodityid;

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property(strong,nonatomic)UILabel *placeholderLabel;
@property (strong, nonatomic) IBOutlet UIView *viewForPhoto;

@property(strong,nonatomic)NSMutableArray *imageArray;


- (IBAction)comfirm:(UIButton *)sender;

@end

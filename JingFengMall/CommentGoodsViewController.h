//
//  CommentGoodsViewController.h
//  JingFengMall
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallOrderModel.h"
#import "TQStarRatingView.h"


@interface CommentGoodsViewController : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,StarRatingViewDelegate>

@property(strong,nonatomic)MallOrderModel *order;

@property (strong, nonatomic) IBOutlet TQStarRatingView *startView;


@property (strong, nonatomic) IBOutlet UIView *viewForPhoto;

@property (strong, nonatomic) IBOutlet UITextView *comment;

@property(copy,nonatomic)NSString *commentLevel;

@property(strong,nonatomic)NSMutableArray *imageArray;

@end

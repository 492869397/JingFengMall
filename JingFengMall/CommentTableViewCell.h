//
//  CommentTableViewCell.h
//  JingFengMall
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CommentModel.h"
#import "StaticStarLevelView.h"

@interface CommentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet StaticStarLevelView *startLevelView;

@property(strong,nonatomic)CommentModel *commentModel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@property (strong, nonatomic) IBOutlet UIView *viewForImage;
@property (strong, nonatomic) IBOutlet UILabel *comment;
@property (strong, nonatomic) IBOutlet UILabel *commentPerson;

@end

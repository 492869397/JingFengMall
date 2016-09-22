//
//  CommentModel.h
//  JingFengMall
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property(copy,nonatomic)NSString *user;

@property(copy,nonatomic)NSString *commodityID;

@property(copy,nonatomic)NSString *comment;

@property(copy,nonatomic)NSString *level;

@property(copy,nonatomic)NSString *photo;

-(id)initWithUser:(NSString*)user commodityID:(NSString*)commodityID comment:(NSString*)comment level:(NSString*)level photo:(NSString*)photo;

@end

//
//  CommentModel.m
//  JingFengMall
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

-(id)initWithUser:(NSString*)user commodityID:(NSString*)commodityID comment:(NSString*)comment level:(NSString*)level photo:(NSString*)photo
{
    if (self = [super init]) {
        
        self.user = user;
        self.commodityID = commodityID;
        self.comment = comment;
        self.level = level;
        self.photo = photo;
        
    }
    
    return self;
}

@end

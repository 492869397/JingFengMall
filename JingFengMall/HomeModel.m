//
//  HomeModel.m
//  JingFengMall
//
//  Created by len on 16/5/5.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

/*
 "id": 2,
 "price": "100元/小时",
 "name": "赵阿姨",
 "score": 5,
 "label": "神准时,整洁,",
 "photo": "http://123.57.28.11:8080/jfsc_app/images/bj2.jpg"
 
*/

-(id)initWithID:(NSNumber *)homeID upid:(NSString*)upid type:(NSString*)type photoURL:(NSString*)photoURL{
    
    if (self = [super init]) {
        self.upid = upid;
        self.type = type;
        self.photo = photoURL;
        self.Iid = homeID;
    }
    
    return self;
    
}

@end

//
//  Streaming.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/23/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Streaming : NSObject
@property (nonatomic, strong) NSString *streamID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *streamTitle;
@property (nonatomic, strong) NSString *streamDetail;
@property (nonatomic, strong) NSString *streamCreateDate;
@property (nonatomic, strong) NSString *streamUpdateDate;
@property (nonatomic, strong) NSString *streamTotalView;
@property (nonatomic, strong) NSString *category;
@property NSInteger categoryID;
@property (nonatomic, strong) NSString *categoryCountStream;
@property  NSInteger lovesCount;
@property _Bool isLoved;
@property _Bool isPublic;
@property (nonatomic, strong) NSString *watchedCount;
@property (nonatomic, strong) NSString *web_url;

@property (nonatomic, strong) NSString *snapshot;
@property (nonatomic, strong) NSString *streamUrl;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *createBy;
@property (nonatomic, strong) NSString *timeCreate;
@property (nonatomic, assign) NSInteger rowIndex;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *msgStatus;
@property (nonatomic, strong) NSString *avatarUrl;
@end

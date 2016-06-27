//
//  AppDelegate.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 6/17/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

//User Data
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) NSString *access_token;
@property (strong,nonatomic) NSString *birth_date;
@property (strong,nonatomic) NSString *profile_picture;
@property (strong,nonatomic) NSString *first_name;
@property (strong,nonatomic) NSString *last_name;
@property (strong,nonatomic) NSString *user_ID;
@property (strong,nonatomic) NSString *social_access_token;
@property (strong,nonatomic) NSString *social_birth_date;
//Curent Location
@property double latitude;
@property double longitude;
@property NSString *locationName;

//Stream Data
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *SSIDName;
@property (strong,nonatomic) NSString *osVersion;
@property (strong,nonatomic) NSString *carrierName;
@property (strong,nonatomic) NSString *deviceType;
@property (strong,nonatomic) NSString *UUID;
@property (strong,nonatomic) NSString *appVersion;
@property _Bool isChat;
@property _Bool isShare;

@property (strong,nonatomic) NSString *pageName;
@property _Bool isLogin;
@property _Bool isMoreVedio;
@property _Bool isLiveVC;
@property  int *isProfile;
@property _Bool isPromotion;
@property _Bool hasPromotion;
@property (strong,nonatomic) NSString* comment_type;
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSDictionary *topPage;
@property (strong,nonatomic) NSDictionary *topPattaya;
@property (strong,nonatomic) NSDictionary *topPhuket;
@property (strong,nonatomic) NSDictionary *topAll;

@property (strong,nonatomic) NSString* CCTV_ID;
@property (strong,nonatomic) NSMutableArray* imgArr ;
@property (strong,nonatomic) NSMutableArray* timeArr ;


@property (strong,nonatomic) NSString* socketScreenName;

@property _Bool isSearch;

@property UserData *followData;

//mydestination
@property _Bool isEdit;


//temp
@property (strong,nonatomic) NSMutableArray* helpfulData;
@property (strong,nonatomic) NSMutableArray* categoryData;


@end


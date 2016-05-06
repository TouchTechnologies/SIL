//
//  userData.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 3/9/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserData : NSObject

@property (nonatomic, strong) NSString *count_follower;
@property (nonatomic, strong) NSString *count_following;
@property BOOL is_followed;
@property (nonatomic, strong) NSString *dislikes;
@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *profile_picture;
@property (nonatomic, strong) NSString *file_path;
@property (nonatomic, strong) NSString *first_name;
@property (nonatomic, strong) NSString *last_name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *undislikes;
@property (nonatomic, strong) NSString *unlikes;


@end

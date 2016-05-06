//
//  Commentator.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 4/26/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commentator : NSObject
@property (nonatomic, strong) NSString *comment_content;
@property (nonatomic, strong) NSString *profile_picture;
@property (nonatomic, strong) NSString *profile_id;
@property (nonatomic, strong) NSString *first_name;
@property (nonatomic, strong) NSString *last_name;
@property (nonatomic, strong) NSString *email;

@end
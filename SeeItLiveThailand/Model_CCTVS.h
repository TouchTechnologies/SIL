//
//  Model_CCTVS.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 3/1/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_CCTVS : NSObject
//CCTVS TB
@property (nonatomic,strong) NSString *id_provider_information_tag_keyname;
@property (nonatomic,strong) NSString *id_cctv;
@property (nonatomic,strong) NSString *label_en;
@property (nonatomic,strong) NSString *description_en;
@property (nonatomic,strong) NSString *live_url;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *created;
@property (nonatomic,strong) NSString *updated;
@property (nonatomic,strong) NSString *view;
@property (nonatomic,strong) NSString *online_status;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,assign) NSInteger rowIndex;

//

@end


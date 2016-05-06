//
//  Model_ROI.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 3/1/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_ROI : NSObject
//provider TB
@property (nonatomic,strong) NSString *id_provider_information_tag_keyname;
@property (nonatomic,strong) NSString *provider_information_tag_keyname;
@property (nonatomic,strong) NSString *provider_information_tag_type;
@property (nonatomic,strong) NSString *provider_information_tag_name;
@property (nonatomic,strong) NSString *label_en;
@property (nonatomic,strong) NSString *label_th;
@property (nonatomic,strong) NSString *logo_image;
@property (nonatomic,strong) NSString *cover_image;
@property (nonatomic,strong) NSString *banner_image;
@property (nonatomic,strong) NSString *active_status;
@property (nonatomic,strong) NSString *order_record;
@property (nonatomic,strong) NSString *created;
@property (nonatomic,strong) NSString *updated;
@property (nonatomic,strong) NSString *retio1;
@property (nonatomic,strong) NSString *ratio2;
@property (nonatomic,strong) NSString *order1;
@property (nonatomic,strong) NSString *max_created;
@property (nonatomic,strong) NSString *cover_url;
@property (nonatomic,strong) NSString *roi_name_en;
@property (nonatomic,strong) NSString *roi_name_th;
@property (nonatomic,strong) NSString *total_view;
@end
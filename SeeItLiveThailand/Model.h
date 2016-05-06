//
//  Model.h
//  DataBaseDemo
//
//  Created by TheAppGuruz-New-6 on 22/02/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property (nonatomic,strong) NSString *rollnum;
@property (nonatomic,strong) NSString *name;
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

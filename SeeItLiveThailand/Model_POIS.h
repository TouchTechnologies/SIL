//
//  Pois.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 3/25/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Model_POIS: NSObject

@property (nonatomic, strong) NSString *provider_type_id;
@property (nonatomic, strong) NSString *provider_type_keyname;
@property (nonatomic, strong) NSString *name_en;
@property (nonatomic, strong) NSString *name_th;
@property (nonatomic, strong) NSString *province_name_en;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *address_th;
@property (nonatomic, strong) NSString *address_en;
@property  float distance;
@property CLLocation *location;


@end
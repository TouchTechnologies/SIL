//
//  ROI.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/7/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface ROI : NSObject
@property (nonatomic, strong) NSString *roiName;
@property  long int roiSort;
@property  float distance;
@property CLLocation *location;
@property (nonatomic, strong) NSString *roiKeyName;
@property (nonatomic, strong) NSString *roiTagKeyName;
@property (nonatomic, strong) NSArray *cctvs;
@end

//
//  DXAnnotation.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/12/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DXAnnotation : NSObject<MKAnnotation>
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, assign) NSInteger tag;
@property(nonatomic, strong) NSString *pinName;
@end

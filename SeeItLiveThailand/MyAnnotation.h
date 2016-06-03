//
//  MyAnnotation.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 6/2/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface MyAnnotation : NSObject <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
}

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

@end

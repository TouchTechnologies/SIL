//
//  PoiManager.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 3/25/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#ifndef PoiManager_h
#define PoiManager_h
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "AppDelegate.h"
#import "defs.h"
#import "Model_POIS.h"
#import "ModelManager.h"


@interface PoiManager : NSObject
+(PoiManager*)shareIntance;

-(void)getAPIData:(NSString*)apiName Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;
-(void)getPOIData:(NSString*)apiName Completion:(void (^)( NSError *error,NSMutableArray * result, NSString * message))completion;
@end
#endif /* PoiManager_h */

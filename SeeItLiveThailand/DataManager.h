//
//  DataManager.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/8/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ROI;
typedef void (^ROICompletionBlock)(BOOL success,NSArray *roiRecords,NSError *error);
typedef void (^StreamingCompletionBlock)(BOOL success,NSArray *streamRecords,NSError *error);
typedef void (^StreamingLiveCompletionBlock)(BOOL success,NSArray *streamRecords,NSError *error);

@interface DataManager : NSObject

+ (id)shareManager;
- (void)getStreamingWithCompletionBlockWithFilterCat:(StreamingCompletionBlock)block  Filter:(NSString*)filter;
- (void)getCCTVwithCompletionBlock:(ROICompletionBlock)block;
- (void)getCCTVwithCompletionBlockDatabase:(ROICompletionBlock)block;
- (void)getStreamingWithCompletionBlock:(StreamingCompletionBlock)block;
- (void)getStreamingWithCompletionBlockWithFilter:(StreamingCompletionBlock)block  Filter:(NSString*)filter;
- (void)getStreamingWithCompletionBlockByCatgoryID:(StreamingCompletionBlock)block :(int)catID;
- (void)getMyStreamingWithCompletionBlock:(StreamingCompletionBlock)block;
- (void)getStreamingLiveWithCompletionBlock:(StreamingCompletionBlock)block;
- (NSMutableArray *)getData;
@end

//
//  DataManager.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/8/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "DataManager.h"
#import "ROI.h"
#import "CCTVS.h"
#import "Streaming.h"
#import "defs.h"
#import "UserManager.h"
#import "AppDelegate.h"
#import "ModelManager.h"
#import <AFNetworking.h>

static NSString *kRoiApiURL = @"http://office.touch-ics.com:81/framework/api/rois";

@interface DataManager()
@property (nonatomic, copy) ROICompletionBlock roiBlock;
@property (nonatomic, copy) StreamingCompletionBlock streamingBlock;
@property (nonatomic, copy) StreamingLiveCompletionBlock streamingLiveBlock;
@end

@implementation DataManager

static DataManager *staticManager = nil;

+ (id)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        staticManager = [[DataManager alloc] init];
    });
    
    return staticManager;
}

#pragma mark - ROI Api

- (void)getCCTVwithCompletionBlock:(ROICompletionBlock)block {
    if (block) {
        self.roiBlock = block;
        [self downloadROIdetailForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:RoiApiURL]]];
    }
}
- (void)getCCTVwithCompletionBlockDatabase:(ROICompletionBlock)block {
    if (block) {
        self.roiBlock = block;
        self.roiBlock(YES,nil,nil);
    }
}

- (void)downloadROIdetailForRequest:(NSURLRequest *)request {
    __weak DataManager *weakSelf = self;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (!connectionError) {
            NSError *jsonParsingError = nil;
            NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
            
//            NSLog(@"DATA ROI %@",jsonResults);
            
            [weakSelf createRoiObjectForRecords:(NSArray *)jsonResults];
        } else {
            weakSelf.roiBlock(NO,nil,connectionError);
        }
        
    }];
}
- (void)createRoiObjectForRecords:(NSArray *)records {
    
    NSMutableArray *recordObjects = [NSMutableArray array];
    NSMutableArray *model_roiObjects = [NSMutableArray array];
    ModelManager *modelManager=[ModelManager getInstance];
    NSLog(@"Delete All");
    [modelManager deleteAllData];
    for (NSDictionary *roiRecord in records) {
        ROI *roi = [[ROI alloc] init];
        Model_ROI *model_roi=[[Model_ROI alloc]init];
        
        
        NSMutableArray *cctvObjects = [NSMutableArray array];
        NSMutableArray *model_cctvObjects = [NSMutableArray array];
        
        NSNumber *rowIndex = @(0);
        
        for (NSDictionary *cctvRecord in roiRecord[@"cctvs"]) {
            CCTVS *cctvs = [[CCTVS alloc] init];
            Model_CCTVS *model_cctvs=[[Model_CCTVS alloc]init];
            cctvs.cctvID = cctvRecord[@"id_cctv"];
            cctvs.cctvName = cctvRecord[@"label_en"];
            cctvs.cctvDesc = cctvRecord[@"description_en"];
            cctvs.imageUrl = cctvRecord[@"live_url"];
            cctvs.latitude = cctvRecord[@"latitude"];
            cctvs.longitude = cctvRecord[@"longitude"];
            cctvs.timeCreate = cctvRecord[@"created"];
            cctvs.timeUpdated = cctvRecord[@"updated"];
            cctvs.totalView = cctvRecord[@"view"];
            
            model_cctvs.id_cctv = cctvRecord[@"id_cctv"];
            model_cctvs.label_en = cctvRecord[@"label_en"];
            model_cctvs.description_en = cctvRecord[@"description_en"];
            model_cctvs.live_url = cctvRecord[@"live_url"];
            model_cctvs.latitude = cctvRecord[@"latitude"];
            model_cctvs.longitude = cctvRecord[@"longitude"];
            model_cctvs.created = cctvRecord[@"created"];
            model_cctvs.updated = cctvRecord[@"updated"];
            model_cctvs.view = cctvRecord[@"view"];
            model_cctvs.online_status = cctvRecord[@"online_status"];
            
            
            
            for (NSDictionary *url in cctvRecord[@"url"]) {
//                NSLog(@"WTFDATACCTV %@",cctvRecord[@"url"]);
                model_cctvs.url = url[@"url"];
                
                model_cctvs.id_provider_information_tag_keyname = [NSString stringWithFormat:@"%ld", [url[@"id"] integerValue]];
//                NSLog(@"iddddddd : %@",[NSString stringWithFormat:@"%ld", [url[@"id"] integerValue]]);
                
                ;
                cctvs.shareUrl = url[@"url"];
            }
            
            model_cctvs.rowIndex = [rowIndex integerValue];
            cctvs.rowIndex = [rowIndex integerValue];
            
            rowIndex = @([rowIndex intValue] + 1);
            
//            cctvs = [modelManager getCCTVSData:[rowIndex intValue]];
//            NSLog(@"cctvs Data all %@",[modelManager getCCTVSData:[rowIndex intValue]]);
//            [modelManager insertCCTVSData:model_cctvs];
            
            [cctvObjects addObject:cctvs];
            [model_cctvObjects addObject:model_cctvs];
        }
        
        if (cctvObjects.count) {

            model_roi.provider_information_tag_name = roiRecord[@"provider_information_tag_name"];
            model_roi.provider_information_tag_keyname = roiRecord[@"provider_information_tag_keyname"];
            model_roi.id_provider_information_tag_keyname = roiRecord[@"id_provider_information_tag_keyname"];
            model_roi.provider_information_tag_type = roiRecord[@"provider_information_tag_type"];
            model_roi.total_view = roiRecord[@"total_view"];
            NSLog(@"insert CCTV");
            [modelManager insertCCTVSData:model_cctvObjects];
            
//            NSLog(@"cctvObjects %@",model_cctvObjects);
            
            roi.roiName = roiRecord[@"provider_information_tag_name"];
            roi.roiTagKeyName = roiRecord[@"id_provider_information_tag_keyname"];
            roi.roiKeyName = roiRecord[@"provider_information_tag_keyname"];
            //            roi.roiTotalView = roiRecord[@"view_period"];
            roi.cctvs = [NSArray arrayWithArray:cctvObjects];
//            roi.cctvs = [NSArray arrayWithArray:[modelManager getCCTVSData]];
//            [recordObjects addObject:roi];
            [model_roiObjects addObject:model_roi];
        }
        
    }

    NSLog(@"insert ROI");
    [modelManager insertROIData:model_roiObjects];
//    [modelManager displayData];
//    [modelManager getJoinTB];
//    [modelManager displayCCTVSData];
//    [modelManager getAllData];
    if(self.roiBlock) {
        self.roiBlock(YES,[NSArray arrayWithArray:recordObjects],nil);
    }
}

//- (void)createRoiObjectForRecords:(NSArray *)records {
//    
//    NSMutableArray *recordObjects = [NSMutableArray array];
//    ModelManager *modelManager=[ModelManager getInstance];
//    //    NSLog(@"Delete All");
//    //    [modelManager deleteAllData];
//    for (NSDictionary *roiRecord in records) {
//        ROI *roi = [[ROI alloc] init];
//        Model_ROI *model_roi=[[Model_ROI alloc]init];
//        Model_CCTVS *model_cctvs=[[Model_CCTVS alloc]init];
//        
//        NSMutableArray *cctvObjects = [NSMutableArray array];
//        NSNumber *rowIndex = @(0);
//        
//        for (NSDictionary *cctvRecord in roiRecord[@"cctvs"]) {
//            CCTVS *cctvs = [[CCTVS alloc] init];
//            cctvs.cctvID = cctvRecord[@"id_cctv"];
//            cctvs.cctvName = cctvRecord[@"label_en"];
//            cctvs.cctvDesc = cctvRecord[@"description_en"];
//            cctvs.imageUrl = cctvRecord[@"live_url"];
//            cctvs.latitude = cctvRecord[@"latitude"];
//            cctvs.longitude = cctvRecord[@"longitude"];
//            cctvs.timeCreate = cctvRecord[@"created"];
//            cctvs.timeUpdated = cctvRecord[@"updated"];
//            cctvs.totalView = cctvRecord[@"view"];
//            
//            model_cctvs.id_cctv = cctvRecord[@"id_cctv"];
//            model_cctvs.label_en = cctvRecord[@"label_en"];
//            model_cctvs.description_en = cctvRecord[@"description_en"];
//            model_cctvs.live_url = cctvRecord[@"live_url"];
//            model_cctvs.latitude = cctvRecord[@"latitude"];
//            model_cctvs.longitude = cctvRecord[@"longitude"];
//            model_cctvs.created = cctvRecord[@"created"];
//            model_cctvs.updated = cctvRecord[@"updated"];
//            model_cctvs.view = cctvRecord[@"view"];
//            
//            
//            
//            
//            //            NSLog(@"totalViewFun %@",cctvRecord[@"view_period"]);
//            
//            for (NSDictionary *url in cctvRecord[@"url"]) {
//                model_cctvs.url = url[@"url"];
//                cctvs.shareUrl = url[@"url"];
//            }
//            
//            model_cctvs.rowIndex = [rowIndex integerValue];
//            cctvs.rowIndex = [rowIndex integerValue];
//            
//            [modelManager insertCCTVSData:model_cctvs];
//            rowIndex = @([rowIndex intValue] + 1);
//            
//            //            cctvs = [modelManager getCCTVSData:[rowIndex intValue]];
//            //            NSLog(@"cctvs Data all %@",[modelManager getCCTVSData:[rowIndex intValue]]);
//            
//            [modelManager displayCCTVSData];
//            [cctvObjects addObject:cctvs];
//        }
//        
//        if (cctvObjects.count) {
//            
//            model_roi.provider_information_tag_name = roiRecord[@"provider_information_tag_name"];
//            model_roi.provider_information_tag_keyname = roiRecord[@"provider_information_tag_keyname"];
//            model_roi.id_provider_information_tag_keyname = roiRecord[@"id_provider_information_tag_keyname"];
//            model_roi.provider_information_tag_type = roiRecord[@"provider_information_tag_type"];
//            
//            
//            [modelManager displayData];
//            NSLog(@"insert All");
//            [modelManager insertROIData:model_roi];
//            roi = [modelManager getROIData];
//            
//            
//            //            roi.roiName = roiRecord[@"provider_information_tag_name"];
//            //            roi.roiTagKeyName = roiRecord[@"id_provider_information_tag_keyname"];
//            //            roi.roiKeyName = roiRecord[@"provider_information_tag_keyname"];
//            //            roi.roiTotalView = roiRecord[@"view_period"];
//            roi.cctvs = [NSArray arrayWithArray:cctvObjects];
//            [recordObjects addObject:roi];
//        }
//        
//        
//    }
//    
//    
//    if(self.roiBlock) {
//        self.roiBlock(YES,[NSArray arrayWithArray:recordObjects],nil);
//    }
//}

#pragma mark - Streaming Api

- (void)getStreamingWithCompletionBlock:(StreamingCompletionBlock)block {
    if (block) {
        self.streamingBlock = block;
        [self downloadStreamingDetailForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:StreamingHistoryURL]]];
    }
}
- (void)getStreamingWithCompletionBlockWithFilterCat:(StreamingCompletionBlock)block  Filter:(NSString*)filter{
    if (block) {
        NSString *StreamingHistoryFilterURL ;
        if(filter != nil)
        {
            StreamingHistoryFilterURL = [StreamingHistoryURLByCatgory stringByAppendingFormat:@"%@",filter];
        }else
        {
            StreamingHistoryFilterURL = StreamingHistoryURLByCatgory;
        }
        self.streamingBlock = block;
        NSLog(@"URLLLLLL %@",StreamingHistoryFilterURL);
        [self downloadStreamingDetailForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:StreamingHistoryFilterURL]]];
    }
}
- (void)getStreamingWithCompletionBlockWithFilter:(StreamingCompletionBlock)block  Filter:(NSString*)filter{
    if (block) {
        
        NSString *StreamingHistoryFilterURL ;
        if(filter != nil)
        {
            StreamingHistoryFilterURL = [StreamingHistoryURL stringByAppendingFormat:@"%@",filter];
        }else
        {
            StreamingHistoryFilterURL = StreamingHistoryURL;
        }
        self.streamingBlock = block;
        NSLog(@"00000000000000000000000000000000");
        [self downloadStreamingDetailForRequestfilter:[NSURLRequest requestWithURL:[NSURL URLWithString:StreamingHistoryFilterURL]]];
    }
}
- (void)getMyStreamingWithCompletionBlock:(StreamingCompletionBlock)block {
    if (block) {
        self.streamingBlock = block;
        [self downloadMyStreamingDetailForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:StreamingHistoryURL]]];
    }
}
- (void)getStreamingWithCompletionBlockByCatgoryID:(StreamingCompletionBlock)block :(int)catID{
    if (block) {
        
        
        self.streamingBlock = block;
//        NSLog(@"StreamingHistoryURLByCatgory : %@",[StreamingHistoryURLByCatgory stringByAppendingFormat:@"%d",catID]);
        [self downloadStreamingDetailForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[StreamingHistoryURLByCatgory stringByAppendingFormat:@"%d",catID]]]];
    }
}

- (void)downloadStreamingDetailForRequest:(NSURLRequest *)request {
    __weak DataManager *weakSelf = self;

    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    NSDictionary * param = @{};
    NSLog(@"request : %@",[NSString stringWithFormat:@"%@",request.URL]);
    [manager GET:[request.URL absoluteString] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        NSLog(@"downloadStreamingDetailForRequestData : %@ Count ",responseObject);
//createStreamingObjectForRecordsfilter
        [weakSelf createStreamingObjectForRecords:(NSArray *)responseObject];
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        weakSelf.streamingBlock(NO,nil,error);
    }];
    
}
- (void)downloadStreamingCateDetailForRequest:(NSString *)request {
    __weak DataManager *weakSelf = self;
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    NSDictionary * param = @{};
    NSLog(@"requestURL:::: %@",request);
    [manager GET:request parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        NSLog(@"downloadStreamingCateDetailForRequest: %@ Count ",responseObject);
        
        [weakSelf createStreamingObjectForRecords:(NSArray *)responseObject];
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        weakSelf.streamingBlock(NO,nil,error);
    }];
    
}
- (void)downloadMyStreamingDetailForRequest:(NSURLRequest *)request {
    __weak DataManager *weakSelf = self;
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    //    NSDictionary *jsonDict = @{@"access_token":appDelegate.access_token};
    
    [[UserManager shareIntance]getMyStream:appDelegate.access_token Completion:^(NSError *error, NSDictionary *result, NSString *message){
        
        
        
        if (!error) {
            //
            //            NSError *jsonParsingError = nil;
            //            NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
            
            [weakSelf createMyStreamingObjectForRecords:(NSArray *)result];
            
//            NSLog(@"All MyStream Result : %@",result);
            
        } else {
            weakSelf.streamingBlock(NO,nil,error);
        }
        
        
    }];
    
}


- (void)createStreamingObjectForRecords:(NSArray *)record {
    
    NSMutableArray *recordObjects = [NSMutableArray array];
    
//    NSLog(@"All recordObjects %@",record);
    for (NSDictionary *stmRecord in record) {
        Streaming *stream = [[Streaming alloc] init];
        stream.ID = stmRecord[@"id_stream"];
        stream.userID = stmRecord[@"user_id"];
        stream.streamUserName = stmRecord[@"user"][@"email"];
        stream.streamUserImage = stmRecord[@"user"][@"profile_picture"];
        stream.streamUserFollowerCount = stmRecord[@"user"][@"count_follower"];
        stream.streamID = stmRecord[@"id_stream"];
        stream.streamTitle = stmRecord[@"title"];
        
        stream.streamDetail = stmRecord[@"note"];
        stream.streamUpdateDate = stmRecord[@"updatedate"];
        stream.streamTotalView = stmRecord[@"watchedCount"];
        stream.streamCreateDate = stmRecord[@"createdate"];
        stream.lovesCount = [stmRecord[@"loves_count"] integerValue];
        stream.isLoved = [stmRecord[@"is_loved"] integerValue];
        stream.web_url = stmRecord[@"web_url"];
        
//      stream.snapshot = stmRecord[@"snapshots"][@"320x240"];
        stream.snapshot = stmRecord[@"list_snapshot"][@"320x240"];
        stream.streamUrl = stmRecord[@"urls"][@"http"];
        stream.createBy = stmRecord[@"user"][@"first_name"];
        stream.timeCreate = stmRecord[@"createdate"];
        stream.latitude = stmRecord[@"latitude"];
        stream.longitude = stmRecord[@"longitude"];
        stream.avatarUrl = stmRecord[@"user"][@"profile_picture"];
        stream.category = stmRecord[@"category_stream"][@"category_name_en"];
        stream.categoryID = [stmRecord[@"category_id"] integerValue];
        stream.categoryName = stmRecord[@"category_stream"][@"category_name_en"];
        stream.categoryImage = stmRecord[@"category_stream"][@"icon_category"];
        stream.categoryCountStream = stmRecord[@"category_stream"][@"count_stream"];
        stream.count_comment = stmRecord[@"count_comment"];
        
        //NSLog(@"%@",stream.avatarUrl);
        
        [recordObjects addObject:stream];
    }
    
    if (self.streamingBlock) {
        self.streamingBlock(YES,[NSArray arrayWithArray:recordObjects],nil);
    }
}
- (void)createMyStreamingObjectForRecords:(NSArray *)record {
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    NSMutableArray *recordObjects = [NSMutableArray array];
    NSLog(@"RecordMyStream:: %@",record);
    for (NSDictionary *stmRecord in record) {
        Streaming *stream = [[Streaming alloc] init];
        stream.ID = stmRecord[@"id_stream"];
        stream.userID = stmRecord[@"user_id"];
        stream.streamID = stmRecord[@"id_stream"];
        stream.streamTitle = stmRecord[@"title"];
        stream.streamDetail = stmRecord[@"note"];
        stream.streamUpdateDate = stmRecord[@"updatedate"];
        stream.streamTotalView = stmRecord[@"watchedCount"];
        stream.streamCreateDate = stmRecord[@"createdate"];
        
        stream.watchingCount = stmRecord[@"watchingCount"];
        stream.watchedCount = stmRecord[@"watchedCount"];
        stream.lovesCount = [stmRecord[@"loves_count"] integerValue];
        stream.isLoved = [stmRecord[@"is_loved"] integerValue];
        stream.web_url = stmRecord[@"web_url"];
        stream.isPublic = [stmRecord[@"public"] integerValue];
        
        stream.snapshot = stmRecord[@"list_snapshot"][@"320x240"];
        stream.streamUrl = stmRecord[@"list_url"][@"http"];
        stream.createBy = appDelegate.first_name;
        stream.timeCreate = stmRecord[@"createdate"];
        stream.latitude = stmRecord[@"latitude"];
        stream.longitude = stmRecord[@"longitude"];
        stream.avatarUrl = stmRecord[@"user"][@"profile_picture"];
        stream.count_comment = stmRecord[@"count_comment"];
        stream.categoryID = [stmRecord[@"category_id"] integerValue];

        stream.count_follower = [stmRecord[@"user"][@"count_follower"] integerValue];
        stream.count_following = [stmRecord[@"user"][@"count_following"] integerValue];
//        NSLog(@"count_following %@",stmRecord[@"user"][@"count_following"]);
        
        for(NSDictionary *cateName in appDelegate.categoryData)
        {
            if(stream.categoryID == [cateName[@"id"] integerValue])
            {
//                NSLog(@"CateName : %@",cateName[@"category_name_en"]);
                stream.categoryName  = cateName[@"category_name_en"];
                stream.categoryImage = cateName[@"icon_category"];
            }
            
        }

        
        
//        NSLog(@"stream title :%@",stmRecord[@"title"]);
//        NSLog(@"stmRecord URL :%@",stmRecord[@"list_url"][@"http"]);
        
        [recordObjects addObject:stream];
    }
    
    if (self.streamingBlock) {
        self.streamingBlock(YES,[NSArray arrayWithArray:recordObjects],nil);
    }
}


- (void)downloadStreamingDetailForRequestfilter:(NSURLRequest *)request {
    __weak DataManager *weakSelf = self;
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    NSDictionary * param = @{};
    NSLog(@"request : %@",[NSString stringWithFormat:@"%@",request.URL]);
    [manager GET:[request.URL absoluteString] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        NSLog(@"downloadStreamingDetailForRequestData : %@ Count ",responseObject);
        //createStreamingObjectForRecordsfilter
        [weakSelf createStreamingObjectForRecordsfilter:(NSArray *)responseObject];
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        weakSelf.streamingBlock(NO,nil,error);
    }];
    
}
- (void)createStreamingObjectForRecordsfilter:(NSArray *)record {
    
    NSMutableArray *recordObjects = [NSMutableArray array];
    
    //    NSLog(@"All recordObjects %@",record);
    for (NSDictionary *stmRecord in record) {
        Streaming *stream = [[Streaming alloc] init];
        stream.ID = stmRecord[@"id_stream"];
        stream.userID = stmRecord[@"user_id"];
        stream.streamUserName = stmRecord[@"user"][@"email"];
        stream.streamUserImage = stmRecord[@"user"][@"profile_picture"];
        stream.streamUserFollowerCount = stmRecord[@"user"][@"count_follower"];
        stream.streamID = stmRecord[@"id_stream"];
        stream.streamTitle = stmRecord[@"title"];
        
        stream.streamDetail = stmRecord[@"note"];
        stream.streamUpdateDate = stmRecord[@"updatedate"];
        stream.streamTotalView = stmRecord[@"watchedCount"];
        stream.streamCreateDate = stmRecord[@"createdate"];
        stream.lovesCount = [stmRecord[@"loves_count"] integerValue];
        stream.isLoved = [stmRecord[@"is_loved"] integerValue];
        stream.web_url = stmRecord[@"web_url"];
        
        //      stream.snapshot = stmRecord[@"snapshots"][@"320x240"];
        stream.snapshot = stmRecord[@"list_snapshot"][@"320x240"];
        stream.streamUrl = stmRecord[@"list_url"][@"http"];
        stream.createBy = stmRecord[@"user"][@"first_name"];
        stream.timeCreate = stmRecord[@"createdate"];
        stream.latitude = stmRecord[@"latitude"];
        stream.longitude = stmRecord[@"longitude"];
        stream.avatarUrl = stmRecord[@"user"][@"profile_picture"];
        stream.category = stmRecord[@"category_stream"][@"category_name_en"];
        stream.categoryID = [stmRecord[@"category_id"] integerValue];
        stream.categoryName = stmRecord[@"category_stream"][@"category_name_en"];
        stream.categoryImage = stmRecord[@"category_stream"][@"icon_category"];
        stream.categoryCountStream = stmRecord[@"category_stream"][@"count_stream"];
        stream.count_comment = stmRecord[@"count_comment"];
        
        //NSLog(@"%@",stream.avatarUrl);
        
        [recordObjects addObject:stream];
    }
    
    if (self.streamingBlock) {
        self.streamingBlock(YES,[NSArray arrayWithArray:recordObjects],nil);
    }
}

#pragma mark - Live Streaming Api


- (void)getStreamingLiveWithCompletionBlock:(StreamingLiveCompletionBlock)block {
    if (block) {
        self.streamingLiveBlock = block;
        [self downloadStreamingLiveDetailForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:StreamingLiveURL]]];
    }
}

- (void)downloadStreamingLiveDetailForRequest:(NSURLRequest *)request {
    __weak DataManager *weakSelf = self;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //NSString *json = @"";
        
        if (!connectionError) {
            //NSLog(@"save json to file");
            //[self saveJsonWithData:data];
            
            
            NSError *jsonParsingError = nil;
            NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
            
            //NSLog(@"%@",jsonResults);
            
            [weakSelf createStreamingLiveObjectForRecords:jsonResults];
            
            
            
        } else {
            weakSelf.streamingLiveBlock(NO,nil,connectionError);
        }
        
    }];
}

- (void)createStreamingLiveObjectForRecords:(NSDictionary *)records {
    
    NSLog(@"createStreamingLiveObjectForRecords : %@",records);
    //NSLog(@"%@",records[@"status"]);
    //NSLog(@"%@",records[@"message"]);
    
    
    NSMutableArray *recordObjects = [NSMutableArray array];
    
    if([records[@"status"] intValue] == 0) {
        //NSLog(@"status is 0");
        NSArray *channelList = (NSArray *)records[@"data"][@"streamingChannels"];
        
        for (NSDictionary *channel in channelList) {
            //NSLog(@"%@",channel[@"channelID"]);
            //NSLog(@"%@",channel[@"streamings"]);
            
            for (NSDictionary *stmRecord in channel[@"streamings"]) {
                Streaming *stream = [[Streaming alloc] init];
                stream.ID = stmRecord[@"id"];
                stream.streamID = stmRecord[@"streamingID"];
                stream.streamTitle = stmRecord[@"title"];
                stream.snapshot = stmRecord[@"snapshots"][@"320x240"];
                stream.streamUrl = stmRecord[@"urls"][@"http"];
                stream.isLoved = ([stmRecord[@"is_loved"] integerValue] == 1) ? TRUE : FALSE;
                stream.lovesCount = [stmRecord[@"loves_count"] integerValue];
                stream.watchingCount = stmRecord[@"watchingCount"];
                stream.watchedCount = stmRecord[@"watchedCount"];
                //stream.timeCreate = stmRecord[@"createdate"];
                stream.createBy = stmRecord[@"user"][@"first_name"];
                stream.latitude = stmRecord[@"geolocation"][@"latitude"];
                stream.longitude = stmRecord[@"geolocation"][@"longitude"];
                stream.avatarUrl = stmRecord[@"user"][@"profile_picture"];
                
                NSLog(@"%@",stream.avatarUrl);
                NSLog(@"stmRecord Love : %@",stmRecord[@"is_loved"]);
                
                [recordObjects addObject:stream];
            }
        }
        
        //NSLog(@"%@",channel);
    }
    
    if (self.streamingLiveBlock) {
        NSLog(@"Live streaming block");
        self.streamingLiveBlock(YES,[NSArray arrayWithArray:recordObjects],nil);
    }
    
}

-(void)saveJsonWithData:(NSData *)data{
    
    NSString *jsonPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/liveStreaming.json"];
    
    NSLog(@"%@",jsonPath);
    
    [data writeToFile:jsonPath atomically:YES];
    NSLog(@"save complete");
}

-(NSData *)getSavedJsonData{
    NSString *jsonPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/liveStreaming.json"];
    
    return [NSData dataWithContentsOfFile:jsonPath];
}


@end

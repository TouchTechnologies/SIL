//
//  ModelManager.h
//  DataBaseDemo
//
//  Created by TheAppGuruz-New-6 on 22/02/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model_ROI.h"
#import "Model_CCTVS.h"
#import "FMDatabase.h"
#import "Util.h"
#import "ROI.h"
#import "CCTVS.h"
#import "Model_TopPage.h"
#import "Model_POIS.h"

@interface ModelManager : NSObject
@property (nonatomic,strong) FMDatabase *database;

+(ModelManager *) getInstance;

-(void) displayData;
-(void) displayCCTVSData;
-(ROI *) getROIData;

-(NSMutableArray *) getTopPage;
-(NSMutableArray *) getAllData;
-(NSMutableArray *) getAllDataSort;
-(NSMutableArray *) getPOIDataDB;
-(NSArray *) getMyDestData;

-(NSMutableArray *)getCCTVSData:(NSString *)key;
-(void)getCCTVSData2:(NSString *)key;
//-(void) insertData:(Model_ROI *)data;
-(void) insertROIData:(NSArray *)data;
-(void) insertCCTVSData:(NSArray *)data;
-(void) insertTopPageData:(NSArray *)dataArr;
-(void) insertPOIData:(NSArray *)dataArr;
-(void) insertMyDestData:(Model_POIS *)data;
//-(void) updateData:(Model_ROI *)data;
//-(void) deleteData:(Model_ROI *)data;
-(void) getJoinTB;
-(void) deleteAllData;
-(BOOL) deleteMyDestData;
-(BOOL) deleteMyDestDataByType:(NSString*)type;
-(BOOL) deleteMyDestDataByID:(NSString*)name_en;


@end

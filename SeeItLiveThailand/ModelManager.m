//
//  ModelManager.m
//  DataBaseDemo
//
//  Created by TheAppGuruz-New-6 on 22/02/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import "ModelManager.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
@implementation ModelManager

static ModelManager *instance=nil;
@synthesize database=_database;

+(ModelManager *) getInstance
{
    
    if(!instance)
    {
        instance=[[ModelManager alloc]init];
        //        instance.database=[FMDatabase databaseWithPath:[Util getFilePath:@"studentdb.sqlite"]];
        instance.database=[FMDatabase databaseWithPath:[Util getFilePath:@"SIL_db.sqlite"]];
    }
    return instance;
}

-(void)insertROIData:(NSArray *)dataArr
{
    [instance.database open];
    BOOL isInserted = false;
    
    NSLog(@"insertROISData Count : %lu",(unsigned long)dataArr.count);
    
    for (Model_ROI *data in dataArr) {
        isInserted = [instance.database executeUpdate:@"INSERT INTO providerTB (provider_information_tag_name,id_provider_information_tag_keyname,provider_information_tag_keyname,total_view) VALUES (?,?,?,?)",data.provider_information_tag_name,data.id_provider_information_tag_keyname,data.provider_information_tag_keyname,data.total_view];
        
        
        NSLog(@"insertROIDataIn %@",data.total_view);
    }
    
    [instance.database close];
    //    [self displayCCTVSData];
    
    if(isInserted)
        NSLog(@"insertROIData Successfully");
    else
        NSLog(@"Error occured while inserting");
    
    
    
    
    
    //    [instance.database open];
    //    BOOL isInserted=[instance.database executeUpdate:@"INSERT INTO providerTB (provider_information_tag_name,id_provider_information_tag_keyname,provider_information_tag_keyname) VALUES (?,?,?)",data.provider_information_tag_name,data.id_provider_information_tag_keyname,data.provider_information_tag_keyname];
    //    [instance.database close];
    //
    //    if(isInserted)
    //        NSLog(@"insertROIData Successfully %@",data.id_provider_information_tag_keyname);
    //    else
    //        NSLog(@"Error occured while inserting");
}
-(void)insertCCTVSData:(NSArray *)dataArr
{
    [instance.database open];
    BOOL isInserted = false;
    
    //    NSLog(@"insertCCTVSData Count : %lu",(unsigned long)dataArr.count);
    
    for (Model_CCTVS *data in dataArr) {
        isInserted = [instance.database executeUpdate:@"INSERT INTO cctvsTB (id_provider_information_tag_keyname,id_cctv,label_en,description_en,live_url,latitude,longitude,created,updated,view,url,online_status,row_index) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?);" withArgumentsInArray:@[data.id_provider_information_tag_keyname,data.id_cctv, data.label_en, data.description_en, data.live_url, data.latitude, data.longitude,data.created,data.updated,data.view,data.url,data.online_status,@(data.rowIndex)]];
        
        NSLog(@"insertCCTVSDataIn %@",data.online_status);
    }
    
    [instance.database close];
    //    [self displayCCTVSData];
    
    if(isInserted)
        NSLog(@"insertCCTVSData Successfully");
    else
        NSLog(@"Error occured while inserting");
}

//-(void)updateData:(Model_ROI *)data
//{
//    [instance.database open];
//    BOOL isUpdated=[instance.database executeUpdate:@"UPDATE studentInfo SET name=? WHERE rollnum=?",data.name,data.rollnum];
//    [instance.database close];
//
//    if(isUpdated)
//        NSLog(@"Updated Successfully");
//    else
//        NSLog(@"Error occured while Updating");
//}

//-(void)deleteData:(Model_ROI *)data
//{
//    [instance.database open];
//    BOOL isDeleted=[instance.database executeUpdate:@"DELETE FROM studentInfo WHERE rollnum=?",data.rollnum];
//    [instance.database close];
//
//    if(isDeleted)
//        NSLog(@"Deleted Successfully");
//    else
//        NSLog(@"Error occured while Deleting");
//}
-(void)deleteAllData
{
    [instance.database open];
    BOOL isDeleted=[instance.database executeUpdate:@"DELETE FROM providerTB"];
    isDeleted=[instance.database executeUpdate:@"DELETE FROM cctvsTB"];
    [instance.database close];
    
    if(isDeleted)
        NSLog(@"Deleted Successfully");
    else
        NSLog(@"Error occured while Deleting");
}

-(void) displayData
{
    int count = 0;
    [instance.database open];
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT * FROM providerTB"];
    if(resultSet)
    {
        while([resultSet next])
        {
            NSLog(@"displayData : name : %@    id_keyname : %@  keyname : %@",
                  [resultSet stringForColumn:@"provider_information_tag_name"],
                  [resultSet stringForColumn:@"id_provider_information_tag_keyname"],
                  [resultSet stringForColumn:@"provider_information_tag_keyname"]);
            count++;
        }
    }
    NSLog(@"ROICount : %d",count);
    [instance.database close];
}
-(void) displayCCTVSData
{
    
    [instance.database open];
    int count = 0;
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT * FROM cctvsTB"];
    NSLog(@"displayCCTVSData");
    if(resultSet)
    {
        while([resultSet next]){
            
            NSLog(@"BATMAN cctv name : %@    latitude : %@  longitude : %@",
                  [resultSet stringForColumn:@"label_en"],
                  [resultSet stringForColumn:@"latitude"],
                  [resultSet stringForColumn:@"longitude"]);
            count++;
        }
    }
    NSLog(@"CCTVCount : %d",count);
    [instance.database close];
}

- (void)getJoinTB
{
    int count = 0;
    [instance.database open];
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT providerTB.*,cctvsTB.* FROM providerTB LEFT JOIN cctvsTB ON providerTB.id_provider_information_tag_keyname = cctvsTB.id_provider_information_tag_keyname"];
    NSLog(@"displayCCTVSData getJoinTB");
    if(resultSet)
    {
        while([resultSet next]){
            NSLog(@"BATMAN %@  id_cctv : %@    label_en : %@  providerId : %@ cctvID : %@",
                  [resultSet stringForColumn:@"provider_information_tag_name"],
                  [resultSet stringForColumn:@"id_cctv"],
                  [resultSet stringForColumn:@"label_en"],
                  [resultSet stringForColumn:@"providerTB.id_provider_information_tag_keyname"],
                  [resultSet stringForColumn:@"providerTB.id_provider_information_tag_keyname"]);
            count++;
        }
    }
    NSLog(@"getJoinTBCount : %d",count);
    [instance.database close];
}
- (void)insertTopPageData:(NSArray *)dataArr
{
    [instance.database open];
    BOOL isDeleted = [instance.database executeUpdate:@"DELETE FROM topPageTB"];
    [instance.database close];
    
    if(isDeleted)
        NSLog(@"Deleted topPageTB Successfully");
    else
        NSLog(@"Error occured while Deleting");
    
    [instance.database open];
    BOOL isInserted = false;
    
    NSLog(@"insertTopPageData Count : %lu",(unsigned long)dataArr.count);
    
    for (Model_TopPage *data in dataArr) {
        isInserted = [instance.database executeUpdate:@"INSERT INTO topPageTB (coverURL,name,totalView) VALUES (?,?,?)",data.coverURL,data.name,data.totalView];
        
        
        NSLog(@"insertTopPageData %@",data.name);
    }
    
    [instance.database close];
    //    [self displayCCTVSData];
    
    if(isInserted)
    {
        NSLog(@"insertTopPageData Successfully");
        //        [self getTopPage];
    }
    else
        NSLog(@"Error occured while inserting");
}
- (NSMutableArray *)getTopPage
{
    
    int count = 0;
    NSMutableArray *topPageObjects = [NSMutableArray array];
    [instance.database open];
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT * FROM topPageTB"];
    if(resultSet)
    {
        while([resultSet next]){
            Model_TopPage *topPage = [[Model_TopPage alloc] init];
            topPage.name = [resultSet stringForColumn:@"name"];
            topPage.coverURL = [resultSet stringForColumn:@"coverURL"];
            topPage.totalView = [resultSet stringForColumn:@"totalView"];
            NSLog(@"promotion  name : %@    coverURL : %@  totalView : %@ ",
                  [resultSet stringForColumn:@"name"],
                  [resultSet stringForColumn:@"coverURL"],
                  [resultSet stringForColumn:@"totalView"]);
            count++;
            [topPageObjects addObject:topPage];
        }
    }
    NSLog(@"getTopPageCount : %d",count);
    [instance.database close];
    return topPageObjects;
    
}

-(NSMutableArray *)getAllData
{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:appDelegate.latitude longitude:appDelegate.longitude];
    
    [instance.database open];
    NSMutableArray *recordObjects = [NSMutableArray array];
    //    NSMutableArray *AllObjects = [NSMutableArray array];
    NSMutableArray *cctvObjects = [NSMutableArray array];
    ROI *roi = [[ROI alloc] init];
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT providerTB.*,cctvsTB.* FROM providerTB LEFT JOIN cctvsTB ON providerTB.id_provider_information_tag_keyname = cctvsTB.id_provider_information_tag_keyname"];
    int count = 0;
    if(resultSet)
    {
        //        NSLog(@"resultSet %@",resultSet);
        
        while([resultSet next])
        {
            NSLog(@"ROI NAME :: %@",[resultSet stringForColumn:@"provider_information_tag_name"]);
            NSLog(@"CCTV NAME :: %@",[resultSet stringForColumn:@"label_en"]);
            CCTVS *cctvs = [[CCTVS alloc] init];
            
            //            NSLog(@"batman id %@",[resultSet stringForColumn:@"id_provider_information_tag_keyname"]);
            if(![roi.roiTagKeyName isEqualToString:[resultSet stringForColumn:@"id_provider_information_tag_keyname"]] && (roi.roiTagKeyName != nil))
            {
                count++;
                NSLog(@"roiTagKeyName %@ id_provider_information_tag_keyname %@",roi.roiTagKeyName ,[resultSet stringForColumn:@"id_provider_information_tag_keyname"]);
                
                NSLog(@"count in if1 : %d",count);
                
                roi.cctvs = [NSArray arrayWithArray:cctvObjects];
                
                [cctvObjects removeAllObjects];
                NSLog(@"ALL ROI %@",roi);
                [recordObjects addObject:roi];
                roi = [[ROI alloc] init];
            }
            
            roi.roiName = [resultSet stringForColumn:@"provider_information_tag_name"];
            roi.roiTagKeyName = [resultSet stringForColumn:@"id_provider_information_tag_keyname"];
            roi.roiKeyName = [resultSet stringForColumn:@"provider_information_tag_keyname"];
            roi.location = [[CLLocation alloc] initWithLatitude:[[resultSet stringForColumn:@"latitude"] integerValue] longitude:[[resultSet stringForColumn:@"longitude"] integerValue]];
            CLLocation *roiLocation = [[CLLocation alloc] initWithLatitude:[[resultSet stringForColumn:@"latitude"] floatValue] longitude:[[resultSet stringForColumn:@"longitude"] floatValue]];
            
            CLLocationDistance meters = [roiLocation distanceFromLocation:currentLoc];
            //            [self displayCCTVSData];
            
            //            NSLog(@"Roi Name %@ current %@ & %@ distance km : %f == %f ",roi.roiName,[resultSet stringForColumn:@"latitude"],[resultSet stringForColumn:@"longitude"],meters/1000.0,met/1000.0);
            roi.distance = meters/1000;
            cctvs.distance = meters/1000;
            NSLog(@"idcctvs %@",[resultSet stringForColumn:@"id_cctv"]);
            cctvs.cctvID = [resultSet stringForColumn:@"id_cctv"];
            cctvs.cctvName = [resultSet stringForColumn:@"label_en"];
            cctvs.cctvDesc = [resultSet stringForColumn:@"description_en"];
            cctvs.imageUrl = [resultSet stringForColumn:@"live_url"];
            cctvs.latitude = [resultSet stringForColumn:@"latitude"];
            cctvs.longitude = [resultSet stringForColumn:@"longitude"];
            cctvs.timeCreate = [resultSet stringForColumn:@"created"];
            cctvs.timeUpdated = [resultSet stringForColumn:@"updated"];
            cctvs.totalView = [resultSet stringForColumn:@"view"];
            cctvs.shareUrl = [resultSet stringForColumn:@"url"];
            
            
            [cctvObjects addObject:cctvs];
            NSLog(@"ALL cctvObjects %@ ",cctvObjects);
            
        }
        if(count)
        {
            count++;
            NSLog(@"count in if2 : %d",count);
            roi.cctvs = [NSArray arrayWithArray:cctvObjects];
            [recordObjects addObject:roi];
            NSLog(@"in result set");
        }
        
        
    }
    
    
    NSLog(@"Count : %d AllDatagetAllData :%@",count,recordObjects);
    
    NSLog(@"===========================================");
    [self getROIData];
    NSLog(@"===========================================");
    NSLog(@"getCCTVSData : %@",[self getCCTVSData:@"aaa"]);
    
    [instance.database close];
    return recordObjects;
}
-(NSMutableArray *)getAllDataSort
{
    //    [self displayCCTVSData];
    NSLog(@"getAllDataSort");
    [instance.database open];
    NSMutableArray *recordObjects = [NSMutableArray array];
    //    NSMutableArray *AllObjects = [NSMutableArray array];
    NSMutableArray *cctvObjects = [NSMutableArray array];
    ROI *roi = [[ROI alloc] init];
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT providerTB.*,cctvsTB.* FROM providerTB LEFT JOIN cctvsTB ON providerTB.id_provider_information_tag_keyname = cctvsTB.id_provider_information_tag_keyname"];
    int count = 0;
    if(resultSet)
    {
        NSLog(@"resultSet %@",resultSet);
        
        while([resultSet next])
        {
            
            
            CCTVS *cctvs = [[CCTVS alloc] init];
            
            NSLog(@" id %@",[resultSet stringForColumn:@"id_provider_information_tag_keyname"]);
            if(![roi.roiTagKeyName isEqualToString:[resultSet stringForColumn:@"id_provider_information_tag_keyname"]] && (roi.roiTagKeyName != nil))
            {
                count++;
                NSLog(@"roiTagKeyName %@ id_provider_information_tag_keyname %@",roi.roiTagKeyName ,[resultSet stringForColumn:@"id_provider_information_tag_keyname"]);
                
                NSLog(@"count in if1 : %d",count);
                
                roi.cctvs = [NSArray arrayWithArray:cctvObjects];
                
                [cctvObjects removeAllObjects];
                NSLog(@"ALL ROI %@",roi);
                [recordObjects addObject:roi];
                roi = [[ROI alloc] init];
            }
            
            roi.roiName = [resultSet stringForColumn:@"provider_information_tag_name"];
            roi.roiTagKeyName = [resultSet stringForColumn:@"id_provider_information_tag_keyname"];
            roi.roiKeyName = [resultSet stringForColumn:@"provider_information_tag_keyname"];
            
            NSLog(@"online_status %@",[resultSet stringForColumn:@"online_status"]);
            if ([[resultSet stringForColumn:@"online_status"] isEqualToString:@"1"]) {
                roi.roiSort = (roi.roiSort < [[resultSet stringForColumn:@"view"] integerValue]) ?[[resultSet stringForColumn:@"view"] integerValue]  : roi.roiSort;
                NSLog(@"==ROI==== %@ =====CCTV=== %@ ==== totalview %ld",roi.roiName,[resultSet stringForColumn:@"label_en"],roi.roiSort);
            }
            
            
            
            NSLog(@"idcctvs %@",[resultSet stringForColumn:@"id_cctv"]);
            cctvs.cctvID = [resultSet stringForColumn:@"id_cctv"];
            cctvs.cctvName = [resultSet stringForColumn:@"label_en"];
            cctvs.cctvDesc = [resultSet stringForColumn:@"description_en"];
            cctvs.imageUrl = [resultSet stringForColumn:@"live_url"];
            cctvs.latitude = [resultSet stringForColumn:@"latitude"];
            cctvs.longitude = [resultSet stringForColumn:@"longitude"];
            cctvs.timeCreate = [resultSet stringForColumn:@"created"];
            cctvs.timeUpdated = [resultSet stringForColumn:@"updated"];
            cctvs.totalView = [resultSet stringForColumn:@"view"];
            cctvs.shareUrl = [resultSet stringForColumn:@"url"];
            
            
            [cctvObjects addObject:cctvs];
            NSLog(@"ALL cctvObjects %@ ",cctvObjects);
            
        }
        if(count)
        {
            count++;
            NSLog(@"count in if2 : %d",count);
            roi.cctvs = [NSArray arrayWithArray:cctvObjects];
            [recordObjects addObject:roi];
            NSLog(@"in result set");
        }
        
        
    }
    
    
    NSLog(@"Count : %d AllDatagetAllData :%@",count,recordObjects);
    
    NSLog(@"===========================================");
    [self getROIData];
    NSLog(@"===========================================");
    NSLog(@"getCCTVSData : %@",[self getCCTVSData:@"aaa"]);
    
    [instance.database close];
    return recordObjects;
}

-(ROI *)getROIData
{
    [instance.database open];
    ROI *roi = [[ROI alloc] init];
    int count = 0;
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT * FROM providerTB"];
    if(resultSet)
    {
        while([resultSet next])
        {
            NSLog(@"provider_information_tag_name : %@    id_provider_information_tag_keyname : %@  provider_information_tag_keyname : %@",
                  [resultSet stringForColumn:@"provider_information_tag_name"],
                  [resultSet stringForColumn:@"id_provider_information_tag_keyname"],
                  [resultSet stringForColumn:@"provider_information_tag_keyname"]);
            roi.roiName = [resultSet stringForColumn:@"provider_information_tag_name"];
            roi.roiTagKeyName = [resultSet stringForColumn:@"id_provider_information_tag_keyname"];
            roi.roiKeyName = [resultSet stringForColumn:@"provider_information_tag_keyname"];
            count++;
        }
    }
    NSLog(@"getROIData : %d",count);
    [instance.database close];
    return roi;
}
-(void) getCCTVSData2:(NSString *)key
{
    [instance.database open];
    NSLog(@"wtfffffffff");
    CCTVS *cctvs = [[CCTVS alloc] init];
    NSMutableArray *cctvObjects = [NSMutableArray array];
    //    NSString *key = @"6";
    //    NSString *search_text = [NSString stringWithFormat:@"%%%@%%", @"1"];
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT * FROM cctvsTB WHERE id_provider_information_tag_keyname LIKE ?",key];
    if(resultSet)
    {
        NSLog(@"resultSet : %@",resultSet);
        while([resultSet next])
        {
            NSLog(@"cctvID : %@",[resultSet stringForColumn:@"id_cctv"]);
            //            cctvs.cctvID = [resultSet stringForColumn:@"id_cctv"];
            //            cctvs.cctvName = [resultSet stringForColumn:@"label_en"];
            //            cctvs.cctvDesc = [resultSet stringForColumn:@"description_en"];
            //            cctvs.imageUrl = [resultSet stringForColumn:@"live_url"];
            //            cctvs.latitude = [resultSet stringForColumn:@"latitude"];
            //            cctvs.longitude = [resultSet stringForColumn:@"longitude"];
            //            cctvs.timeCreate = [resultSet stringForColumn:@"created"];
            //            cctvs.timeUpdated = [resultSet stringForColumn:@"updated"];
            //            cctvs.totalView = [resultSet stringForColumn:@"view"];
            //            cctvs.shareUrl = [resultSet stringForColumn:@"url"];
            //            cctvs.rowIndex = [resultSet intForColumn:@"row_index"];
            
            //            [cctvObjects addObject:cctvs];
            NSLog(@"cctvs data %@",cctvs);
        }
    }
    
    [instance.database close];
    
}
-(NSMutableArray *) getCCTVSData:(NSString *)key
{
    [instance.database open];
    NSLog(@"wtfffffffff");
    CCTVS *cctvs = [[CCTVS alloc] init];
    int count = 0;
    NSMutableArray *cctvObjects = [NSMutableArray array];
    //    NSString *key = @"6";
    //    NSString *search_text = [NSString stringWithFormat:@"%%%@%%", @"1"];
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT * FROM cctvsTB",key];
    if(resultSet)
    {
        NSLog(@"resultSet : %@",resultSet);
        while([resultSet next])
        {
            NSLog(@"cctvID : %@",[resultSet stringForColumn:@"id_cctv"]);
            //            cctvs.cctvID = [resultSet stringForColumn:@"id_cctv"];
            //            cctvs.cctvName = [resultSet stringForColumn:@"label_en"];
            //            cctvs.cctvDesc = [resultSet stringForColumn:@"description_en"];
            //            cctvs.imageUrl = [resultSet stringForColumn:@"live_url"];
            //            cctvs.latitude = [resultSet stringForColumn:@"latitude"];
            //            cctvs.longitude = [resultSet stringForColumn:@"longitude"];
            //            cctvs.timeCreate = [resultSet stringForColumn:@"created"];
            //            cctvs.timeUpdated = [resultSet stringForColumn:@"updated"];
            //            cctvs.totalView = [resultSet stringForColumn:@"view"];
            //            cctvs.shareUrl = [resultSet stringForColumn:@"url"];
            //            cctvs.rowIndex = [resultSet intForColumn:@"row_index"];
            
            //            [cctvObjects addObject:cctvs];
            NSLog(@"cctvs data %@",cctvs);
            count++;
        }
    }
    
    NSLog(@"getCCTVSData ; %d",count);
    [instance.database close];
    
    return cctvObjects;
}

-(void)insertPOIData:(NSArray *)dataArr
{
    
    if([self deletePOIData])
    {
        BOOL isInserted = false;
        [instance.database open];
        NSLog(@"insertPOIData Count : %lu",(unsigned long)dataArr.count);
        for (Model_POIS *data in dataArr) {
            isInserted = [instance.database executeUpdate:@"INSERT INTO poisTB (provider_type_id,provider_type_keyname,name_en,name_th,province_name_en,longitude,latitude,address_th,address_en) VALUES (?,?,?,?,?,?,?,?,?)",data.provider_type_id,data.provider_type_keyname,data.name_en,data.name_th,data.province_name_en,data.longitude,data.latitude,data.address_th,data.address_en];
            
            
            //            NSLog(@"insertPOIDataaddress_en %@",data.address_en);
        }
        
        [instance.database close];
        //    [self displayCCTVSData];
        
        if(isInserted)
            NSLog(@"insertPOIData Successfully");
        else
            NSLog(@"Error occured while inserting");
    }
    
    
}
- (NSMutableArray *)getPOIDataDB
{
    NSLog(@"getPOIDataDB");
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:appDelegate.latitude longitude:appDelegate.longitude];
    int count = 0;
    NSMutableArray *poiObjects = [NSMutableArray array];
    [instance.database open];
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT * FROM poisTB"];
    if(resultSet)
    {
        
        while([resultSet next]){
            NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
            [result setObject:[resultSet stringForColumn:@"provider_type_id"] forKey:@"provider_type_id"];
            [result setObject:[resultSet stringForColumn:@"provider_type_keyname"] forKey:@"provider_type_keyname"];
            [result setObject:[resultSet stringForColumn:@"name_en"] forKey:@"name_en"];
            [result setObject:[resultSet stringForColumn:@"name_th"] forKey:@"name_th"];
            [result setObject:[resultSet stringForColumn:@"province_name_en"] forKey:@"province_name_en"];
            [result setObject:[resultSet stringForColumn:@"longitude"] forKey:@"longitude"];
            [result setObject:[resultSet stringForColumn:@"latitude"] forKey:@"latitude"];
            [result setObject:[resultSet stringForColumn:@"address_th"] forKey:@"address_th"];
            [result setObject:[resultSet stringForColumn:@"address_en"] forKey:@"address_en"];
            
            count++;
            [poiObjects addObject:result];
            
            //            [poiObjects addObject:pois];
        }
    }
    //    NSLog(@"getPOIData : %d",count);
    //    NSLog(@"poiObjects::: %@",poiObjects);
    [instance.database close];
    //    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
    //    NSSortDescriptor *secondDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    //    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
    //    return [poiObjects sortedArrayUsingDescriptors:sortDescriptors];
    return poiObjects;
    
}
-(BOOL)deletePOIData
{
    [instance.database open];
    BOOL isDeleted=[instance.database executeUpdate:@"DELETE FROM poisTB"];
    [instance.database close];
    
    if(isDeleted)
    {
        NSLog(@"Deleted Successfully");
        return true;
    }
    else
    {
        NSLog(@"Error occured while Deleting");
        return false;
    }
}
-(void)insertMyDestData:(Model_POIS *)data
{
    BOOL isInserted = false;
    [instance.database open];
    
    isInserted = [instance.database executeUpdate:@"INSERT INTO myDestinationTB (provider_type_id,provider_type_keyname,name_en,name_th,province_name_en,longitude,latitude,address_th,address_en) VALUES (?,?,?,?,?,?,?,?,?)",data.provider_type_id,data.provider_type_keyname,data.name_en,data.name_th,data.province_name_en,data.longitude,data.latitude,data.address_th,data.address_en];
    
    [instance.database close];
    
    if(isInserted)
        NSLog(@"insertPOIData Successfully");
    else
        NSLog(@"Error occured while inserting");
    
    
}
- (NSArray *)getMyDestData
{
    int count = 0;
    NSMutableArray *myDestObjects = [NSMutableArray array];
    [instance.database open];
    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT * FROM myDestinationTB"];
    if(resultSet)
    {
        
        while([resultSet next]){
            NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
            [result setObject:[resultSet stringForColumn:@"provider_type_id"] forKey:@"provider_type_id"];
            [result setObject:[resultSet stringForColumn:@"provider_type_keyname"] forKey:@"provider_type_keyname"];
            [result setObject:[resultSet stringForColumn:@"name_en"] forKey:@"name_en"];
            [result setObject:[resultSet stringForColumn:@"name_th"] forKey:@"name_th"];
            [result setObject:[resultSet stringForColumn:@"province_name_en"] forKey:@"province_name_en"];
            [result setObject:[resultSet stringForColumn:@"longitude"] forKey:@"longitude"];
            [result setObject:[resultSet stringForColumn:@"latitude"] forKey:@"latitude"];
            [result setObject:[resultSet stringForColumn:@"address_th"] forKey:@"address_th"];
            [result setObject:[resultSet stringForColumn:@"address_en"] forKey:@"address_en"];
            
            count++;
            [myDestObjects addObject:result];
            NSLog(@"Result ::: %@",result);
        }
        
        

    }
     NSLog(@"myDestObjectsCount : %d",count);
     NSLog(@"myDestObjects::: %@",myDestObjects);
    [instance.database close];
    return myDestObjects;
    
}
-(BOOL)deleteMyDestData
{
    [instance.database open];
    BOOL isDeleted=[instance.database executeUpdate:@"DELETE FROM myDestinationTB"];
    [instance.database close];
    
    if(isDeleted)
    {
        NSLog(@"Deleted Successfully");
        return true;
    }
    else
    {
        NSLog(@"Error occured while Deleting");
        return false;
    }
}
-(BOOL)deleteMyDestDataByType:(NSString*)type
{
    [instance.database open];
//    BOOL isDeleted=[instance.database executeUpdate:@"DELETE FROM myDestinationTB"];
        BOOL isDeleted=[instance.database executeUpdate:[NSString stringWithFormat:@"DELETE FROM myDestinationTB WHERE provider_type_keyname = '%@'",type]];
    [instance.database close];
    
    if(isDeleted)
    {
        NSLog(@"Deleted Successfully");
        return true;
    }
    else
    {
        NSLog(@"Error occured while Deleting");
        return false;
    }
}
-(BOOL)deleteMyDestDataByID:(NSString*)name_en
{
    NSLog(@"name_en:%@ and %@",name_en,[NSString stringWithFormat:@"DELETE FROM myDestinationTB WHERE name_en = '%@'",name_en]);
    [instance.database open];
    BOOL isDeleted=[instance.database executeUpdate:[NSString stringWithFormat:@"DELETE FROM myDestinationTB WHERE name_en = '%@'",name_en]];
    [instance.database close];
    if(isDeleted)
    {
        NSLog(@"Deleted Successfully");
        return true;
    }
    else
    {
        NSLog(@"Error occured while Deleting");
        return false;
    }
}
@end

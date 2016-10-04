//
//  PoiManager.m
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 3/25/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "PoiManager.h"



//#define service @"http://www.seeitlivethailand.com/"
//#define service @"http://192.168.9.117/seeitlivethailand/"
@implementation PoiManager

static PoiManager * shareObject;

+(PoiManager*)shareIntance{
    
    if (shareObject == nil) {
        shareObject = [[PoiManager alloc] init];
    }
    return shareObject;
}

-(void)getAPIData:(NSString*)apiName Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * param = @{};
    NSString *apiLink = [@"api/" stringByAppendingString:apiName];
    //    NSLog(@"Full Link API %@",[service stringByAppendingString:apiLink]);
    [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
        //        NSLog(@"Data : %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
    
}
-(void)getPOIData:(NSString*)apiName Completion:(void (^)( NSError *error,NSMutableArray * result, NSString * message))completion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * param = @{};
    NSString *apiLink = @"api/pois";
    //    NSLog(@"Full Link API %@",[service stringByAppendingString:apiLink]);
    [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {

        NSMutableArray* poiObject = [[NSMutableArray alloc]init];
        for(NSDictionary* pois in responseObject)
        {
            Model_POIS* poi = [[Model_POIS alloc]init];
            poi.provider_type_id = pois[@"provider_type_id"];
            poi.provider_type_keyname = pois[@"provider_type_keyname"];
            poi.name_en = pois[@"name_en"];
            poi.name_th = pois[@"name_th"];
            poi.province_name_en = pois[@"province_name_en"];
            poi.longitude = pois[@"longitude"];
            poi.latitude = pois[@"latitude"];
            poi.address_th = pois[@"address_th"];
            poi.address_en = pois[@"address_en"];
            [poiObject addObject:poi];
        }
//        NSLog(@"poiObject : %@",poiObject);
//        ModelManager *modelManager = [ModelManager getInstance];
//        [modelManager insertPOIData:poiObject];
        completion(nil,responseObject,@"Success");
//                NSLog(@"Data responseObject: %@",responseObject);
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
    
}
@end
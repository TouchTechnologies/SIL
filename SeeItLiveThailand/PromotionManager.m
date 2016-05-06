//
//  PromotionManager.m
//  SeeItLiveThailand
//
//  Created by Touch on 1/18/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "PromotionManager.h"
#import <AFNetworking.h>
#import "AppDelegate.h"
#import "defs.h"
#import "ModelManager.h"
@implementation PromotionManager
static PromotionManager * shareObject;

+(PromotionManager*)shareIntance{
    
    if (shareObject == nil) {
        shareObject = [[PromotionManager alloc] init];
    }
    return shareObject;
}
-(void)getPromotion:(NSString *)apiname
         Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    
 //   AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
NSDictionary * param = @{};
    
    NSLog(@"FULL URL %@",[PromotionURL stringByAppendingString:@"/api/mobile_activity"]);
    
    [manager GET:[PromotionURL stringByAppendingString:@"/api/mobile_activity"] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
        
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];

}
//-(void)getTopPage:(NSString*)apiName Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSDictionary * param = @{};
//    NSString *apiLink = [@"api/" stringByAppendingString:apiName];
//    
//    [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
//        
//        completion(nil,responseObject,@"Success");
//        //        NSLog(@"Data : %@",responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
//        completion(error,nil,@"Failed");
//    }];
//}
@end

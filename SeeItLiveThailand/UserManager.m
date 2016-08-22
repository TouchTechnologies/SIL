//
//  UserManager.m
//  TouchCCTV
//
//  Created by weerapons suwanchatree on 12/16/2558 BE.
//  Copyright © 2558 touchtechnologies. All rights reserved.
//


#import "UserManager.h"
#import <AFNetworking.h>
#import "AppDelegate.h"
#import "defs.h"
#import "Streaming.h"


//#define service @"http://www.seeitlivethailand.com/"
//#define service @"http://192.168.9.117/seeitlivethailand/"
@implementation UserManager

static UserManager * shareObject;

+(UserManager*)shareIntance{
    
    if (shareObject == nil) {
        shareObject = [[UserManager alloc] init];
    }
    return shareObject;
}

-(void)registerNewAccount_WithEmail:(NSString*)email
                           Password:(NSString*)password
                    ConfirmPassword:(NSString*)confirmPassword
                          FirstName:(NSString*)firstName
                           LastName:(NSString*)lastName
                         Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * param = @{@"email":email,
                             @"password":password,
                             @"password_confirmation":confirmPassword,
                             @"gender":@"M",
                             @"first_name":firstName,
                             @"last_name":lastName
                             //@"birth_date":@"1985-06-01"
                             };
    
    
    [manager POST:[service stringByAppendingString:@"api/register"] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
//        NSLog(@"Data : %@",responseObject);
//        NSLog(@"Message : %@",responseObject[@"message"]);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
    
}
-(void)validateSocialAccount:(NSString*)social_identifier
                social_access_token:(NSString*)social_access_token
                  Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * param = @{@"identifier":social_identifier,
                             @"access_token":social_access_token
                             };
    
    
    [manager POST:[service stringByAppendingString:@"api/validateSocialAccount/Facebook"] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
//        NSLog(@"Data : %@",responseObject);
        //        NSLog(@"Message : %@",responseObject[@"message"]);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];

}
-(void)loginSocialAccount:(NSString*)social_identifier
         social_access_token:(NSString*)social_access_token
                  Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * param = @{@"identifier":social_identifier,
                             @"access_token":social_access_token
                             };
    
    
    [manager POST:[service stringByAppendingString:@"api/login/Facebook"] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
        //        NSLog(@"Data : %@",responseObject);
        //        NSLog(@"Message : %@",responseObject[@"message"]);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
    
}

-(void)registerNewAccount_WithFaceBook:(NSString*)email
                           access_token:(NSString*)access_token
                        first_name:(NSString*)first_name
                          last_name:(NSString*)last_name
                           birth_date:(NSString*)birth_date
                         Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * param = @{@"email":email,
                             @"first_name":first_name,
                             @"last_name":last_name,
                             @"birth_date":birth_date,
                             @"access_token":access_token
                             };
    
    
    [manager POST:[service stringByAppendingString:@"api/register/Facebook"] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
                NSLog(@"Data : %@",responseObject);
        //        NSLog(@"Message : %@",responseObject[@"message"]);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
    
}

-(void)Login:(NSString*)username Password:(NSString*)password Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * param = @{@"email":username,
                             @"password":password};
    
    
    [manager POST:[service stringByAppendingString:@"api/login"] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
        NSLog(@"Data : %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
    
    
}
-(void)forgotPassword:(NSString *)email Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * param = @{@"email":email};
    
    
    [manager POST:[service stringByAppendingString:@"api/user/resetPassword"] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
        NSLog(@"Data : %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
}
-(void)updateProfile:(NSString *)firstname Lastname:(NSString *)lastname Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"Access Token%@",appDelegate.access_token);
//    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"-X-TIT-ACCESS-TOKEN"];
    NSDictionary * param = @{
                             @"first_name":firstname,
                             @"last_name":lastname,
                             @"access_token":appDelegate.access_token
                             };
    NSString * command = @"api/user/";
    
//    NSString * test = [service stringByAppendingString:[command stringByAppendingString:appDelegate.user_ID]];
    NSLog(@"FULL URL %@",[service stringByAppendingString:[command stringByAppendingString:appDelegate.user_ID]]);
    
    [manager PUT:[service stringByAppendingString:[command stringByAppendingString:appDelegate.user_ID]] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
        NSLog(@"Data : %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
    

}
-(void)getStreamURL:(NSString *)title categoryID:(NSInteger)categoryID Note:(NSString *)note dateTime:(NSString *)dateTime Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"Access Token%@",appDelegate.access_token);
    NSLog(@"Date time stream : %@", dateTime);
    //    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"-X-TIT-ACCESS-TOKEN"];
    
//    "rawAgent":"htc\/htc_asia_wwe\/endeavoru:4.2.2\/JDQ39\/244600.5:user\/release-keys",
    
//    NSDictionary * param = @{
//                             @"title":title,
//                             @"note" :note,
//                             @"access_token":appDelegate.access_token,
//                             @"latitute":appDelegate.latitute,
//                             @"longtitute":appDelegate.longtitute,
//                             @"protocol": @"RTSP",
//                             @"wifiSSID": appDelegate.SSIDName,
//                             @"osVersion":appDelegate.osVersion,
//                             @"operatorName":appDelegate.carrierName,
//                             @"deviceID":appDelegate.UUID,
//                             @"OS":@"iOS",
//                             @"language":@"TH",
//                             @"mobileAgent":appDelegate.deviceType,
//                             };
//
    NSLog(@"categoryID::: %ld",(long)categoryID);
    NSLog(@"latitute %@",[NSString stringWithFormat:@"%.8f", appDelegate.latitude]);
    NSLog(@"longitude %@",[NSString stringWithFormat:@"%.8f", appDelegate.longitude]);
    NSDictionary * param = @{
                             @"title":title,
                             @"note" :note,
                             @"access_token":appDelegate.access_token,
                             @"categoryID":[NSString stringWithFormat:@"%ld",(long)categoryID],
                             @"latitude":[NSString stringWithFormat:@"%.8f", appDelegate.latitude],
                             @"longitude":[NSString stringWithFormat:@"%.8f", appDelegate.longitude],
                             @"protocol": @"RTSP",
                             @"connectingTimeoutDatetime" : dateTime,
                             @"wifiSSID": (appDelegate.SSIDName == NULL)?@"":appDelegate.SSIDName,
                             @"osVersion":(appDelegate.osVersion == NULL)?@"":appDelegate.osVersion,
                             @"operatorName":(appDelegate.carrierName == NULL)?@"":appDelegate.carrierName,
                             @"deviceID":(appDelegate.UUID == NULL)?@"":appDelegate.UUID,
                              @"OS":@"iOS",
                              @"language":@"TH",
                             @"mobileAgent":(appDelegate.deviceType == NULL)?@"":appDelegate.deviceType,
                             };
    
     NSLog(@"%@",appDelegate.SSIDName);
     NSLog(@"%@",appDelegate.osVersion);
     NSLog(@"%@",appDelegate.carrierName);
     NSLog(@"%@",appDelegate.UUID);
     NSLog(@"%@",appDelegate.deviceType);
 
    
    NSString * command = @"api/liveStreamRequest/";
    
    //    NSString * test = [service stringByAppendingString:[command stringByAppendingString:appDelegate.user_ID]];
//    NSLog(@"FULL URL %@",[service stringByAppendingString:command]);
    
    [manager POST:[service stringByAppendingString:command] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        NSLog(@"DataAll : %@",responseObject);
        NSLog(@"status :%@",responseObject[@"status"]);
        if ([responseObject[@"status"] integerValue]  == 0) {
            NSLog(@"got StreamURL");
            completion(nil,responseObject[@"data"],@"Success");
        }
        else{
            completion(responseObject[@"message"],responseObject[@"data"],@"Success");
        }
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
}
-(void)getMyStream:(NSString *)access_token Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    
    NSLog(@"Access Token%@",appDelegate.access_token);
    //    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"-X-TIT-ACCESS-TOKEN"];
    NSDictionary * param = @{
                             @"access_token":appDelegate.access_token
                             };
    
    NSString * command = @"api/stream/myStream/";
    
    //    NSString * test = [service stringByAppendingString:[command stringByAppendingString:appDelegate.user_ID]];
    //    NSLog(@"FULL URL %@",[service stringByAppendingString:command]);
    
    [manager GET:[service stringByAppendingString:command] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        NSLog(@"DataAll : %@",responseObject);
        if (responseObject != nil) {
            NSLog(@"got StreamURL");
            completion(nil,responseObject,@"Success");
        }
        else{
            completion(responseObject[@"message"],responseObject[@"data"],@"Success");
        }
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
}

-(void)deleteMyStream:(NSString *)access_token StreamID:(NSString *)id_stream Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    
    NSLog(@"Access Token%@",appDelegate.access_token);
    //    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"-X-TIT-ACCESS-TOKEN"];
    NSDictionary * param = @{
                             @"access_token":appDelegate.access_token
                             };
//    NSString * command = @"api/user/{id_user}/stream/{id_stream}";
    NSString * command = [@"api/user/" stringByAppendingString:[appDelegate.user_ID stringByAppendingString:[@"/stream/" stringByAppendingString:id_stream]]];
    //    NSString * test = [service stringByAppendingString:[command stringByAppendingString:appDelegate.user_ID]];
    //    NSLog(@"FULL URL %@",[service stringByAppendingString:command]);
    
    [manager DELETE:[service stringByAppendingString:command] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        NSLog(@"DataAll : %@",responseObject);
        if (responseObject != nil) {
            NSLog(@"got StreamURL");
            completion(nil,responseObject,@"Success");
        }
        else{
            completion(responseObject[@"message"],responseObject[@"data"],@"Success");
        }
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
}
-(void)updateMyStream:(NSString *)streamID title:(NSString*)title note:(NSString*)note catID:(NSString*)catID public:(BOOL)public Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    
    NSLog(@"Access Token%@",appDelegate.access_token);
    //    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"-X-TIT-ACCESS-TOKEN"];
    NSDictionary * param = @{
                             @"title" : title,
                             @"note" : note,
                             @"category_id" : catID,
                             @"public" : (public)? @1 : @0
                             };
    NSString * command = [@"api/stream/history/" stringByAppendingString:[streamID stringByAppendingString:@"/"]];
    
    //    NSString * test = [service stringByAppendingString:[command stringByAppendingString:appDelegate.user_ID]];
        NSLog(@"FULL URL %@",[service stringByAppendingString:command]);
    [manager PATCH:[service stringByAppendingString:command] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        NSLog(@"DataAll : %@",responseObject);
        if (responseObject != nil) {
            NSLog(@"got StreamURL");
            completion(nil,responseObject,@"Success");
        }
        else{
            completion(responseObject[@"message"],responseObject[@"data"],@"Success");
        }
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
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

-(void)getCCTVHighlight:(NSString*)apiName Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * param = @{};
    NSString *apiLink = [@"api/" stringByAppendingString:apiName];
    
    [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
        completion(nil,responseObject,@"Success");
        //        NSLog(@"Data : %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
    
}

-(void)loveAPI:(NSString*)apiName streamID:(NSString*)streamID userID:(NSString*)userID Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    NSDictionary * param = @{};
    
    if ([apiName isEqualToString:@"love"]) {
        apiName = [streamID stringByAppendingString:@"/loves"];
        NSString *apiLink = [@"api/stream/history/" stringByAppendingString:apiName];
//        NSLog(@"Full love API : %@",apiLink);
        [manager POST:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            //        NSLog(@"Data : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"unlove"])
    {
        apiName = [streamID stringByAppendingString:@"/loves"];
        NSString *apiLink = [@"api/stream/history/" stringByAppendingString:apiName];
//        NSLog(@"Full love API : %@",apiLink);
        [manager DELETE:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            //        NSLog(@"Data : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
        
    }else if([apiName isEqualToString:@"loveLive"]) {
        apiName = [streamID stringByAppendingString:@"/loves"];
        NSString *apiLink = [@"api/stream/live/" stringByAppendingString:apiName];
        NSLog(@"Full love API : %@",apiLink);
        [manager POST:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            //        NSLog(@"Data : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"unloveLive"])
    {
        apiName = [streamID stringByAppendingString:@"/loves"];
        NSString *apiLink = [@"api/stream/live/" stringByAppendingString:apiName];
        NSLog(@"Full love API : %@",apiLink);
        [manager DELETE:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            //        NSLog(@"Data : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
        
    }
    
}

-(void)commentAPI:(NSString*)apiName cctvID:(NSString*)cctvID data:(Comment *)data Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    if ([apiName isEqualToString:@"getcomment"]) {
        NSDictionary * param = @{};
        apiName = [cctvID stringByAppendingString:@"/comment?filtersPage=1&filterLimit=10"];
        NSString *apiLink = [@"api/cctv/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"getcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"getcommentAll"]) {
        NSDictionary * param = @{};
        apiName = [cctvID stringByAppendingString:@"/comment"];
        NSString *apiLink = [@"api/cctv/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"getcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"postcomment"])
    {
        
        NSDictionary * param = @{@"comment_content":data.commentMsg
                                 };
        apiName = [cctvID stringByAppendingString:@"/comment"];
        NSString *apiLink = [@"api/cctv/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager POST:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"postcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
        
    }else if([apiName isEqualToString:@"delcomment"])
    {
        NSDictionary * param = @{};
        apiName = [cctvID stringByAppendingString:[@"/comment/" stringByAppendingString:data.commentID]];
        NSString *apiLink = [@"api/cctv/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager DELETE:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"deletecommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"getcommentStream"]) {
        NSDictionary * param = @{};
        apiName = [cctvID stringByAppendingString:@"/comment?filtersPage=1&filterLimit=10"];
        NSString *apiLink = [@"api/stream/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"getcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"getcommentAllStream"]) {
        NSDictionary * param = @{};
        apiName = [cctvID stringByAppendingString:@"/comment"];
        NSString *apiLink = [@"api/stream/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"getcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"postcommentStream"])
    {
        
        NSDictionary * param = @{@"comment_content":data.commentMsg
                                 };
        apiName = [cctvID stringByAppendingString:@"/comment"];
        NSString *apiLink = [@"api/stream/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager POST:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"postcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
        
    }else if([apiName isEqualToString:@"delcommentStream"])
    {
        NSDictionary * param = @{};
        apiName = [cctvID stringByAppendingString:[@"/comment/" stringByAppendingString:data.commentID]];
        NSString *apiLink = [@"api/stream/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager DELETE:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"deletecommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }
    //stream/{id}/comment
}
-(void)commentStreamAPI:(NSString*)apiName streamID:(NSString*)streamID data:(Comment *)data Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    if ([apiName isEqualToString:@"getcomment"]) {
        NSDictionary * param = @{};
        apiName = [streamID stringByAppendingString:@"/comment?filtersPage=1&filterLimit=10"];
        NSString *apiLink = [@"api/cctv/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"getcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"getcommentAll"]) {
        NSDictionary * param = @{};
        apiName = [streamID stringByAppendingString:@"/comment"];
        NSString *apiLink = [@"api/cctv/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"getcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"postlivecomment"])
    {
        
        NSDictionary * param = @{@"comment_content":data.commentMsg
                                 };
        apiName = [streamID stringByAppendingString:[@"/comments?access_token=" stringByAppendingString:appDelegate.access_token]];
        NSString *apiLink = [@"api/streamlives/" stringByAppendingString:apiName];
        NSLog(@"Full Live comment API : %@",apiLink);
        [manager POST:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"postcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
        
    }else if([apiName isEqualToString:@"delcomment"])
    {
        NSDictionary * param = @{};
        apiName = [streamID stringByAppendingString:[@"/comment/" stringByAppendingString:data.commentID]];
        NSString *apiLink = [@"api/cctv/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager DELETE:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"deletecommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"getcommentStream"]) {
        NSDictionary * param = @{};
        apiName = [streamID stringByAppendingString:@"/comment?filtersPage=1&filterLimit=10"];
        NSString *apiLink = [@"api/stream/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"getcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"getcommentAllStream"]) {
        NSDictionary * param = @{};
        apiName = [streamID stringByAppendingString:@"/comment"];
        NSString *apiLink = [@"api/stream/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"getcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }else if ([apiName isEqualToString:@"postcommentStream"])
    {
        
        NSDictionary * param = @{@"comment_content":data.commentMsg
                                 };
        apiName = [streamID stringByAppendingString:@"/comment"];
        NSString *apiLink = [@"api/stream/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager POST:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"postcommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
        
    }else if([apiName isEqualToString:@"delcommentStream"])
    {
        NSDictionary * param = @{};
        apiName = [streamID stringByAppendingString:[@"/comment/" stringByAppendingString:data.commentID]];
        NSString *apiLink = [@"api/stream/" stringByAppendingString:apiName];
        NSLog(@"Full comment API : %@",apiLink);
        [manager DELETE:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"deletecommentData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
    }
    //stream/{id}/comment
}
//api/user/following/{id_user}

-(void)followAPI:(NSString*)apiName userID:(NSString*)userID followingUserID:(NSString*)followingUserID Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    NSDictionary * param = @{};
    ///api/user/{id_user}/following/{id_following_user}
    if ([apiName isEqualToString:@"follow"]) {
        NSString *apiLink = [@"api/user/" stringByAppendingString:[userID stringByAppendingString:[@"/following/" stringByAppendingString:followingUserID]]];
        NSLog(@"Full follow API : %@",apiLink);
        [manager POST:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"followData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
        
    }else if ([apiName isEqualToString:@"unfollow"])
    {
        NSString *apiLink = [@"api/user/" stringByAppendingString:[userID stringByAppendingString:[@"/following/" stringByAppendingString:followingUserID]]];
        NSLog(@"Full unfollow API : %@",apiLink);
        [manager DELETE:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject,@"Success");
            NSLog(@"unfollowData : %@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
        
    }else if ([apiName isEqualToString:@"getfollow"])
    {
        NSString *apiLink = [@"api/user/" stringByAppendingString:userID];
        NSLog(@"Full getfollow API : %@",apiLink);
        [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            completion(nil,responseObject[@"data"],@"Success");
//            NSLog(@"getfollowData : %@",responseObject[@"data"]);
            
        } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
            completion(error,nil,@"Failed");
        }];
        
    }
    
}
-(void)getStreamDataByID:(NSString*)apiName userID:(NSString*)userID Completion:(void (^)( NSError *error,NSArray * result, BOOL success))completion
{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:appDelegate.access_token forHTTPHeaderField:@"X-TIT-ACCESS-TOKEN"];
    
    NSDictionary * param = @{};
    NSMutableArray *streamObjects = [NSMutableArray array];
    //api/user/{id_user}/stream
    NSString *apiLink = [@"api/user/" stringByAppendingString:[userID stringByAppendingString:@"/stream"]];
    NSLog(@"Full getStreamData API : %@",apiLink);
    [manager GET:[service stringByAppendingString:apiLink] parameters:param success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        
         NSLog(@"getStreamData : %@",responseObject);
        for (NSDictionary *stmRecord in responseObject)
        {
            Streaming *stream = [[Streaming alloc] init];
            
            stream.userID = stmRecord[@"user_id"];
            stream.streamID = stmRecord[@"id_stream"];
            stream.streamTitle = stmRecord[@"title"];
            
            stream.streamDetail = stmRecord[@"note"];
            stream.streamUpdateDate = stmRecord[@"updatedate"];
            stream.streamTotalView = stmRecord[@"watchedCount"];
            stream.streamCreateDate = stmRecord[@"createdate"];
            stream.lovesCount = [stmRecord[@"loves_count"] integerValue];
            stream.isLoved = [stmRecord[@"is_loved"] integerValue];
            stream.web_url = stmRecord[@"web_url"];
            
            stream.snapshot = stmRecord[@"list_snapshot"][@"320x240"];
            stream.streamUrl = stmRecord[@"list_url"][@"http"];
            stream.createBy = stmRecord[@"user"][@"first_name"];
            stream.timeCreate = stmRecord[@"createdate"];
            stream.latitude = stmRecord[@"latitude"];
            stream.longitude = stmRecord[@"longitude"];
            stream.avatarUrl = stmRecord[@"user"][@"profile_picture"];
            
            [streamObjects addObject:stream];
        }
        completion(nil,streamObjects,@"Success");
       
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        completion(error,nil,@"Failed");
    }];
    
}
@end



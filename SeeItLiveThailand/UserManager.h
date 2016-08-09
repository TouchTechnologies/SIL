//
//  UserManager.h
//  TouchCCTV
//
//  Created by weerapons suwanchatree on 12/16/2558 BE.
//  Copyright © 2558 touchtechnologies. All rights reserved.
//

#ifndef UserManager_h
#define UserManager_h
#import <Foundation/Foundation.h>
#import "Comment.h"
#import "UserData.h"

@interface UserManager : NSObject
+(UserManager*)shareIntance;

-(void)registerNewAccount_WithEmail:(NSString*)email
                           Password:(NSString*)password
                    ConfirmPassword:(NSString*)confirmPassword
                          FirstName:(NSString*)firstName
                           LastName:(NSString*)lastName
                         Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;
-(void)validateSocialAccount:(NSString*)social_identifier
         social_access_token:(NSString*)social_access_token
                  Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;
-(void)loginSocialAccount:(NSString*)social_identifier
      social_access_token:(NSString*)social_access_token
               Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;
-(void)registerNewAccount_WithFaceBook:(NSString*)email
                          access_token:(NSString*)access_token
                            first_name:(NSString*)first_name
                             last_name:(NSString*)last_name
                            birth_date:(NSString*)birth_date
                            Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;

-(void)Login:(NSString*)username Password:(NSString*)password Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;

-(void)forgotPassword:(NSString*)email Completion:(void (^)(NSError *error,NSDictionary *result,NSString *message))completion;
-(void)updateProfile:(NSString *)firstname Lastname:(NSString *)lastname Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion;
-(void)updateMyStream:(NSString *)streamID title:(NSString*)title note:(NSString*)note catID:(NSString*)catID public:(BOOL)public Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion;
-(void)getStreamURL:(NSString *)title categoryID:(NSInteger)categoryID Note:(NSString *)note dateTime:(NSString *)dateTime Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion;
-(void)commentStreamAPI:(NSString*)apiName streamID:(NSString*)streamID data:(Comment *)data Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;
-(void)deleteMyStream:(NSString *)access_token StreamID:(NSString *)id_stream Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion;
-(void)getAPIData:(NSString*)apiName Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;
-(void)getMyStream:(NSString *)access_token Completion:(void (^)(NSError *, NSDictionary *, NSString *))completion;
-(void)loveAPI:(NSString*)apiName streamID:(NSString*)streamID userID:(NSString*)userID Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;
-(void)commentAPI:(NSString*)apiName cctvID:(NSString*)cctvID data:(Comment *)data Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;
-(void)followAPI:(NSString*)apiName userID:(NSString*)userID followingUserID:(NSString*)followingUserID Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;
-(void)getStreamDataByID:(NSString*)apiName userID:(NSString*)userID Completion:(void (^)( NSError *error,NSArray * result, BOOL success))completion;
@end
#endif /* UserManager_h */

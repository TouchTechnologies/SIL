//
//  PromotionManager.h
//  SeeItLiveThailand
//
//  Created by Touch on 1/18/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromotionManager : NSObject
+(PromotionManager *)shareIntance;
-(void)getPromotion:(NSString *)apiname
                    Completion:(void (^)( NSError *error,NSDictionary * result, NSString * message))completion;



@end

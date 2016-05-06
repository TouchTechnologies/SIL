//
//  MYTapGestureRecognizer.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 3/31/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//
// MYTapGestureRecognizer.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MYTapGestureRecognizer : UITapGestureRecognizer
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end




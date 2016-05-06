//
//  CCTVS.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/7/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCTVS : NSObject
@property (nonatomic, strong) NSString *cctvID;
@property (nonatomic, strong) NSString *cctvName;
@property (nonatomic, strong) NSString *cctvDesc;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *timeCreate;
@property (nonatomic, strong) NSString *timeUpdated;
@property (nonatomic, strong) NSString *totalView;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, assign) NSInteger rowIndex;
@property  float distance;

@end

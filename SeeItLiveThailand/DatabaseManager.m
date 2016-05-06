//
//  DatabaseManager.m
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 2/26/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDB.h"
#import <sqlite3.h>

@interface DatabaseManager : NSObject
{
    sqlite3 *databaseHandle;
}

-(void)initDatabase;

@end

//
//  MyDestinationViewController.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 3/22/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MYTapGestureRecognizer.h"
#import "MYAlertView.h"
#import "PoiManager.h"
#import "ModelManager.h"

@interface MyDestinationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	NSDictionary *tableContents;
    NSArray *sortedKeys;

}
@property (nonatomic, strong) NSDictionary *tableContents;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *searchData;
@property (nonatomic, strong) NSMutableArray *poiData;
@property (nonatomic, strong) NSArray *sortedKeys;

@end

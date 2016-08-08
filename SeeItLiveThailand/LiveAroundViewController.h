//
//  LiveAroundViewController.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 4/27/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MapKit/MapKit.h>
#import "Streaming.h"
@interface LiveAroundViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

}
@property (nonatomic, strong) Streaming *objStreaming;
@property (nonatomic, strong) NSArray *liveAroundData;
@property (nonatomic, assign) NSUInteger rowIndex;

@end

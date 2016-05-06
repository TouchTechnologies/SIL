//
//  HistoryListTableViewController.h
//  SeeItLiveThailand
//
//  Created by Touch on 1/11/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "historyCell.h"
@interface HistoryListTableViewController : UITableViewController
- (IBAction)backtoVdodetailBtn:(id)sender;
@property (nonatomic, strong) NSArray *vdoList;
@property (assign, nonatomic) IBOutlet historyCell *historyCell;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSString* CCTV_ID;
@property (strong,nonatomic) NSMutableArray* imgArr ;
@property (strong,nonatomic) NSMutableArray* timeArr ;

@end

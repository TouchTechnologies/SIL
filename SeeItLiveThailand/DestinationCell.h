//
//  DestinationCell.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 3/22/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationCell : UITableViewCell
{

}
@property (strong, nonatomic) IBOutlet UIImageView *pinIcon;

@property (nonatomic, strong) IBOutlet UILabel *placeLbl;
@property (nonatomic, strong) IBOutlet UILabel *distanceLbl;
@property (nonatomic, strong) IBOutlet UILabel *addressLbl;
@property (nonatomic, strong) IBOutlet UIButton *routeBtn;
@property (strong, nonatomic) IBOutlet UILabel *kmLbl;

@end

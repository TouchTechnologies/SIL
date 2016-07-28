//
//  commentTableViewCell.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 3/11/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *commentLbl;
@property (strong, nonatomic) IBOutlet UILabel *usernameLbl;
@property (strong, nonatomic) IBOutlet UIImageView *usercommentImg;

@end

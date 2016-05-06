//
//  VideoCell.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 6/22/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCell : UITableViewCell {
    
}

@property (strong, nonatomic) UIImageView *imgVideo;


@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UILabel *lblDistance;
@property (nonatomic,strong) UILabel *lblView;
@property (nonatomic,strong) UIImageView *ImgDistance;
@property (nonatomic,strong) UIImageView *ImgView;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;

@end

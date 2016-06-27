//
//  ScreenShotsCell.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/5/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "ScreenShotsCell.h"
#import "TAPageControl.h"

@interface ScreenShotsCell ()
@property (nonatomic, strong) TAPageControl *customPageControl;
@end

@implementation ScreenShotsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state

}
- (void)configureCellForApp:(NSArray *)imageList andCity:(NSString *)city andPlace:(NSString *)place {
    
    CGFloat scWidth = self.frame.size.width;
    CGFloat scHeiht = 240;
    
    UIScrollView *previewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scWidth, scHeiht)];
    [previewScrollView setContentSize:CGSizeMake(scWidth * imageList.count, scHeiht)];
    previewScrollView.pagingEnabled = TRUE;
    previewScrollView.delegate = self;
    [[self contentView] addSubview:previewScrollView];
    
    UIColor *color = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];; // substitute your color here
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:14];
    
    [imageList enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        
        NSString *strPoint = place;
        CGRect frame = [strPoint boundingRectWithSize:CGSizeMake(550, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        CGSize strPointSize = CGSizeMake(frame.size.width, frame.size.height);
        //[strPoint sizeWithFont:font constrainedToSize:CGSizeMake(800, 9999) lineBreakMode:NSLineBreakByWordWrapping];
        
        UIView *viewPlace = [[UIView alloc] initWithFrame:CGRectMake(scWidth * idx, 0, scWidth, scHeiht)];
        viewPlace.backgroundColor = color;
        
        //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scWidth * idx, 0, scWidth, scHeiht)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scWidth, 180)];
        //imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [UIImage imageNamed:imageName];
        [viewPlace addSubview:imageView];
        
        UIImageView *imgIconPlace = [[UIImageView alloc] initWithFrame:CGRectMake(2, 185, 25, 25)];
        imgIconPlace.image = [UIImage imageNamed:@"icon_F.png"];
        [viewPlace addSubview:imgIconPlace];
        
        UILabel *lblPlace = [[UILabel alloc] initWithFrame:CGRectMake(32, 189, 200, 25)];
        lblPlace.text = city;
        [viewPlace addSubview:lblPlace];
        
        
        UILabel *lblPoint = [[UILabel alloc] initWithFrame:CGRectMake(scWidth - (strPointSize.width + 10), 189, strPointSize.width + 10, 25)];
        lblPoint.text = strPoint;
        lblPoint.font = font;
        [viewPlace addSubview:lblPoint];
        
        UIImageView *imgIconPoint = [[UIImageView alloc] initWithFrame:CGRectMake(scWidth - (lblPoint.frame.size.width + 35), 185, 25, 25)];
        imgIconPoint.image = [UIImage imageNamed:@"icon_H.png"];
        [viewPlace addSubview:imgIconPoint];
        
        
        [previewScrollView addSubview:viewPlace];
        
    }];
    
    //self.customPageControl = [[TAPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(previewScrollView.frame)-40, CGRectGetWidth(previewScrollView.frame), 40)];
    //self.customPageControl.numberOfPages = self.imageList.count;
    
    TAPageControl *taPageControl = [[TAPageControl alloc] init];
    taPageControl.frame = CGRectMake(0, CGRectGetMaxY(previewScrollView.frame)-30, CGRectGetWidth(previewScrollView.frame), 30);
    taPageControl.numberOfPages = imageList.count;
    
    [[self contentView] addSubview:taPageControl];
    
}

@end

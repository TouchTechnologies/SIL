//
//  VideoCell.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 6/22/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.imgVideo = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgVideo];
        
        self.ImgDistance = [[UIImageView alloc] init];
        [self.contentView addSubview:self.ImgDistance];
        
        self.ImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.ImgView];
        
        self.lblTitle = [[UILabel alloc] init];
        self.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.lblTitle.numberOfLines = 0;
        //self.lblTitle.font = font;
        self.lblTitle.textAlignment = NSTextAlignmentLeft;
        
        _lblDistance = [[UILabel alloc] init];
        _lblDistance.lineBreakMode = NSLineBreakByWordWrapping;
        _lblDistance.numberOfLines = 0;
        _lblDistance.textAlignment = NSTextAlignmentLeft;
        
        _lblView = [[UILabel alloc] init];
        _lblView.lineBreakMode = NSLineBreakByWordWrapping;
        _lblView.numberOfLines = 0;
        _lblView.textAlignment = NSTextAlignmentLeft;
        
        
        [self.contentView addSubview:self.lblView];
        [self.contentView addSubview:self.lblDistance];
        [self.contentView addSubview:self.lblTitle];
        
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    //[self.lblTitle sizeToFit];
    //[self.lblDetail sizeToFit];
    //self.lblTitle.lineBreakMode = NSLineBreakByCharWrapping;
    //self.lblTitle.textAlignment = NSTextAlignmentLeft;
    //self.lblTitle.numberOfLines = 0;
    //[self.lblTitle sizeToFit];
    
    //UIFont *font = [UIFont fontWithName:@"Helvetica" size:14];
    
    self.imgVideo = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgVideo];
    
    self.lblTitle = [[UILabel alloc] init];
    self.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblTitle.numberOfLines = 0;
    //self.lblTitle.font = font;
    self.lblTitle.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.lblTitle];
    
    //self.contentView.frame.size.width-190
    /*
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:14];
    NSString *strPoint = self.lblTitle.text;
    CGRect frame = [strPoint boundingRectWithSize:CGSizeMake(150, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
    
    //CGSize strPointSize = CGSizeMake(frame.size.width, frame.size.height);
    
    self.lblTitle.frame = CGRectMake(165, (self.contentView.frame.size.height /2) - (frame.size.height/2), 150, frame.size.height);
    self.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblTitle.numberOfLines = 0;    
    self.lblTitle.font = font;
    self.lblTitle.textAlignment = NSTextAlignmentLeft;
    //[self.lblTitle sizeToFit];
    
    NSLog(@"contentView - %f",self.contentView.frame.size.height);
    NSLog(@"frame - %f",frame.size.height);
    
    [self.contentView addSubview:self.lblTitle];
    */ 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

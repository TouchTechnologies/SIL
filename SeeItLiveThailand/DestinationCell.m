//
//  DestinationCell.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 3/22/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "DestinationCell.h"

@implementation DestinationCell
{
    CGRect pinIconRect ;
    CGRect placeLblRect;
    CGRect distanceRect;
    CGRect kmRect;
    CGRect addressLblRect;
    CGRect routeBtnRect;
    
    CGFloat fontPlace;
    CGFloat fontAdd;
//    CGFloat contectVeiwH;

}
- (void)awakeFromNib {
    [self initialSize];
    [self initial];
    // Initialization code
}
-(void)initial{
    [self.contentView setFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
    [self.pinIcon setFrame:pinIconRect];
    [self.placeLbl setFrame:placeLblRect];
    self.placeLbl.font = [UIFont fontWithName:@"Helvetica" size:fontPlace];
    [self.placeLbl sizeThatFits:CGSizeMake(placeLblRect.size.width, 90)];
    [self.distanceLbl setFrame:distanceRect];
    self.distanceLbl.font =[UIFont fontWithName:@"Helvetica" size:fontAdd];
    [self.kmLbl setFrame:kmRect];
    self.kmLbl.font =[UIFont fontWithName:@"Helvetica" size:fontAdd];
    [self.addressLbl setFrame:addressLblRect];
    self.addressLbl.font =[UIFont fontWithName:@"Helvetica" size:fontAdd];
    [self.routeBtn setFrame:routeBtnRect];
    self.routeBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:fontPlace];
    self.routeBtn.layer.cornerRadius = 5;
    self.routeBtn.clipsToBounds = YES;
    
}
-(void)initialSize{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat contentW = self.contentView.bounds.size.width;
    CGFloat contentH = self.contentView.bounds.size.height;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        fontPlace = 16*scy;
        fontAdd = 14*scy;
        pinIconRect = CGRectMake(8*scx, 8*scy , 33*scx, 41*scy);
        
        placeLblRect = CGRectMake(
                                  pinIconRect.origin.x + pinIconRect.size.width + (5*scx),
                                  8*scy,
                                  (contentW*scx)/2, 30*scy);
        distanceRect = CGRectMake(contentW- (85*scx), 10*scy, 45*scx, 30*scy);
        kmRect = CGRectMake(contentW - (35*scx), 10*scy, 30*scx, 30*scy);
        addressLblRect = CGRectMake(8*scx, pinIconRect.origin.y + pinIconRect.size.height + (25*scy),  (contentW*scx) -  (contentW*scx)/3, 30*scy);
          routeBtnRect = CGRectMake(addressLblRect.size.width + (10*scx), (contentH*scy)/2, 75*scx, 45*scy);
    }
    else{
         fontPlace = 16;
         fontAdd = 14;
        pinIconRect = CGRectMake(8, 8 , 33, 41);
        placeLblRect = CGRectMake(pinIconRect.origin.x + pinIconRect.size.width + 5, 8,  self.contentView.bounds.size.width/2, 30);
        distanceRect = CGRectMake(self.contentView.bounds.size.width - 85, 10, 60, 30);
        kmRect = CGRectMake(self.bounds.size.width -35, 10, 30, 30);
        
        addressLblRect = CGRectMake(8, pinIconRect.origin.y + pinIconRect.size.height + 25,  self.contentView.bounds.size.width -  self.contentView.bounds.size.width/3, 30);
        routeBtnRect = CGRectMake(addressLblRect.size.width + 10, self.contentView.bounds.size.height/2, 75, 45);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

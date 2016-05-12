//
//  MyMyStreamingCell.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/26/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "MyStreamingCell.h"
#import "AppDelegate.h"

@implementation MyStreamingCell

//-(NSString *)cellIdentifier{
//    return NSStringFromClass(self);
//}
//
//-(id)cellForGridView:(KKGridView *)gridView{
//    
//    NSString *cellID = [self cellIdentifier];
//    KKGridViewCell *cell = (KKGridViewCell *)[gridView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
//        cell = [[self alloc] initWithFrame:(CGRect){ .size = gridView.cellSize } reuseIdentifier:cellID];
//    }
//    
//    return cell;
//    return self;
//}
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    
  
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
   // frame = CGRectMake(0, 0, 200, 400);
    
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        CGFloat cWidth = self.bounds.size.width;
        CGFloat cHeight = self.bounds.size.height;
        //frame.size = CGSizeMake(cWidth, cHeight+300);
        CGFloat fontSize;
        
        CGRect imgSnapshotRect;
        CGRect lblPlaceRect;
        CGRect lblCreateDescRect;
        CGRect lblCreateByRect;
        
        CGRect imgViewiconRect;
        CGRect lblViewcountRect;
      
        CGRect imgcommentIConRect;
        CGRect lblcommentCountRect;
        
        CGRect imgLoveiconRect;
        CGRect lblLoveCountRect;
    
        CGRect imgShareIconRect;
        
        CGRect editProfilrRect;
        CGRect shareLiveStreamBtnRect;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
           
            fontSize = 13.0 * scx;
            editProfilrRect = CGRectMake(cWidth - (35*scx), 5*scy, 30*scx, 30*scy);
            imgSnapshotRect = CGRectMake(0, 0, cWidth, cHeight);
            
            lblPlaceRect = CGRectMake(2*scx, imgSnapshotRect.size.height +(1*scy) , cWidth - (2*scx), 20*scy);
            lblCreateDescRect = CGRectMake(2*scx,imgSnapshotRect.size.height +(22*scy) , 30*scx, 20*scy);
            lblCreateByRect = CGRectMake(30*scx, imgSnapshotRect.size.height +(22*scy) , cWidth - (32*scx), 20*scy);
            
            imgViewiconRect = CGRectMake(2*scx, imgSnapshotRect.size.height + (43*scy) , 20*scx, 20*scy);
            lblViewcountRect = CGRectMake(30*scx, imgSnapshotRect.size.height +(43*scy ), 50*scx, 20*scy);
            
            lblcommentCountRect = CGRectMake(30*scx, imgSnapshotRect.size.height +(64*scy),50*scx, 20*scy);
            imgcommentIConRect = CGRectMake(2*scx, imgSnapshotRect.size.height +(64*scy),20*scx, 20*scy);
            
            shareLiveStreamBtnRect = CGRectMake(0, 0, 30, 30);
            
            imgLoveiconRect = CGRectMake(80*scx, imgSnapshotRect.size.height +(43*scy), 20*scx, 20*scy);
            lblLoveCountRect = CGRectMake(110*scx, imgSnapshotRect.size.height +(43*scy) , 50*scx, 20*scy);
            imgShareIconRect = CGRectMake(80*scx, imgSnapshotRect.size.height +(64*scy), 20*scx, 20*scy);
            


        } else {
            fontSize = 13.0;
            editProfilrRect = CGRectMake(cWidth - 35, 5, 30, 30);
            imgSnapshotRect = CGRectMake(0, 0, cWidth, cHeight);
            lblPlaceRect = CGRectMake(2, imgSnapshotRect.size.height +1 , cWidth - 2, 20);
            lblCreateDescRect = CGRectMake(2,imgSnapshotRect.size.height +22 , 30, 20);
            lblCreateByRect = CGRectMake(30, imgSnapshotRect.size.height +22 , cWidth - 32, 20);
            imgViewiconRect = CGRectMake(2, imgSnapshotRect.size.height + 43 , 20, 20);
            lblViewcountRect = CGRectMake(30, imgSnapshotRect.size.height +43 , 50, 20);
            
            lblcommentCountRect = CGRectMake(30, imgSnapshotRect.size.height +64,50, 20);
            imgcommentIConRect = CGRectMake(2, imgSnapshotRect.size.height +64,20, 20);
            
            shareLiveStreamBtnRect = CGRectMake(0, 0, 30, 30);
            
            imgLoveiconRect = CGRectMake(80, imgSnapshotRect.size.height +43, 20, 20);
            lblLoveCountRect = CGRectMake(110, imgSnapshotRect.size.height +43 , 50, 20);
            imgShareIconRect = CGRectMake(80, imgSnapshotRect.size.height +64, 20, 20);
        }
        self.layer.cornerRadius = 5 ;
        self.clipsToBounds = YES;
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        self.imgSnapshot = [[UIImageView alloc] initWithFrame:imgSnapshotRect];
        self.imgSnapshot.contentMode = UIViewContentModeScaleToFill;
        
        //[self generateWarterMark];
        
        [self.contentView addSubview:self.imgSnapshot];
        [self.contentView setFrame:frame];
        
        self.lblPlace = [[UILabel alloc] initWithFrame:lblPlaceRect];
        self.lblPlace.font = font;
      //  [self.contentView addSubview:self.lblPlace];
        
        
        self.shareLivestream = [[UIButton alloc] initWithFrame:imgShareIconRect];
        [self.shareLivestream setBackgroundImage:[UIImage imageNamed:@"ic_share21.png"] forState:UIControlStateNormal];
        [self.shareLivestream setBackgroundColor:[UIColor whiteColor]];
      //  [self.contentView addSubview:self.shareLivestream];
        
        self.editLivestream = [[UIButton alloc]initWithFrame:editProfilrRect];
        [self.editLivestream setBackgroundImage:[UIImage imageNamed:@"ic_edit_livestream.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.editLivestream];
        
        
        UILabel *lblCreateDesc = [[UILabel alloc] initWithFrame:lblCreateDescRect];
        lblCreateDesc.font = font;
        lblCreateDesc.text = @"By :";
      //  [self.contentView addSubview:lblCreateDesc];
        
        self.btnCreatbyName = [[UIButton alloc] initWithFrame:lblCreateByRect];
        self.lblCreateBy = [[UILabel alloc] initWithFrame:self.btnCreatbyName.bounds];
        self.lblCreateBy.font = font;
        self.lblCreateBy.textColor = [UIColor blueColor];
        [self.btnCreatbyName addSubview: self.lblCreateBy];
     //   [self.contentView addSubview:self.btnCreatbyName];

        
//        self.lblViewCount = [[UILabel alloc] initWithFrame:lblCreateByRect];
//        self.lblViewCount.font = font;
//        self.lblViewCount.text = @"VIEW :";
//        self.lblViewCount.textColor = [UIColor blueColor];
//        [self.contentView addSubview: self.lblViewCount];
        
        self.imgViewicon = [[UIImageView alloc] initWithFrame:imgViewiconRect];
        self.imgViewicon.image = [UIImage imageNamed:@"ic_alertcomplant.png"];
     //   [self.contentView addSubview:self.imgViewicon];
        
        self.lblViewCount = [[UILabel alloc] initWithFrame:lblViewcountRect];
        self.lblViewCount.font = font;
        self.lblViewCount.textColor = [UIColor blueColor];
    //    [self.contentView addSubview:self.lblViewCount];
        
//        self.lblView = [[UILabel alloc] initWithFrame:lblViewRect];
//        self.lblView.text = @" View";
//        self.lblView.font = font;
//        [self.contentView addSubview:self.lblView];
        self.lblcommentCount = [[UILabel alloc] initWithFrame:lblcommentCountRect];
        self.lblcommentCount.font = font;
    //    [self.contentView addSubview:self.lblcommentCount];
        
        self.commentLivebtn = [[UIButton alloc] initWithFrame:imgcommentIConRect];
        UIImageView *imgcomment = [[UIImageView alloc] initWithFrame:self.commentLivebtn.bounds];
        imgcomment.image = [UIImage imageNamed:@"comment.png"];
        [self.commentLivebtn addSubview:imgcomment];
     //   [self.contentView addSubview:self.commentLivebtn];

        
        
        self.btnLoveicon = [[UIButton alloc] initWithFrame:imgLoveiconRect];

        UIImageView *img = [[UIImageView alloc] initWithFrame:self.btnLoveicon.bounds];
        img.image = [UIImage imageNamed:@"ic_love.png"];
     //   [self.btnLoveicon addSubview:img];
    //    [self.contentView addSubview:self.btnLoveicon];
        
        self.lblLoveCount = [[UILabel alloc] initWithFrame:lblLoveCountRect];
        self.lblLoveCount.font = font;
        self.lblLoveCount.textColor = [UIColor blueColor];
    //    [self.contentView addSubview:self.lblLoveCount];
        
//        self.lblLove = [[UILabel alloc] initWithFrame:lblLoveRect];
//        self.lblLove.text = @" Love";
//        self.lblLove.font = font;
//        [self.contentView addSubview:self.lblLove];
        

    }
    
    return self;
}

- (void)generateWarterMark {
    
    CGRect imgFrame = self.imgSnapshot.bounds;
    CGFloat imgHeight;
    //UIImage *playBig = [UIImage imageNamed:@"VKVideoPlayer_play_big.png"];
   
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        imgHeight = 30.0 * (768.0/360.0);
    } else {
        imgHeight = 30.0;
    }
    
    
   UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgFrame.size.width - (imgHeight+5), imgFrame.size.height-(imgHeight+5), imgHeight, imgHeight)];
    imgView.image = [UIImage imageNamed:@"play.png"];
    imgView.alpha = 0.7f;
    
    [self.imgSnapshot addSubview:imgView];
    
    /*
    UIImage *imgOrigin = self.imgSnapshot.image;
    UIImage *playBig = [UIImage imageNamed:@"VKVideoPlayer_play_big.png"];
    UIGraphicsBeginImageContext(imgOrigin.size);
    
    [imgOrigin drawInRect:CGRectMake(0, 0, imgOrigin.size.width, imgOrigin.size.height)];
    [playBig drawInRect:CGRectMake((imgFrame.size.width/2), (imgFrame.size.height/2), 100, 100)];
    
    self.imgSnapshot.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    */
    
}

@end

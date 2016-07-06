//
//  StreamingCell.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/26/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "StreamingCell.h"
#import <KKGridView/KKGridView.h>
#import "AppDelegate.h"

@implementation StreamingCell
+ (NSString *)cellIdentifier
{
    return NSStringFromClass(self);
}

+ (id)cellForGridView:(KKGridView *)gridView
{
    NSString *cellID = [self cellIdentifier];
    KKGridViewCell *cell = (KKGridViewCell *)[gridView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithFrame:(CGRect){ .size = gridView.cellSize } reuseIdentifier:cellID];
         
    }
    
   

    return cell;
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        
//        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
//        self.backgroundView.backgroundColor = [UIColor redColor];
//        [self addSubview: self.backgroundView];
        CGFloat cWidth = self.bounds.size.width;
        CGFloat cHeight = self.bounds.size.height;
        
        
        CGFloat fontSize;
        
        CGRect imgSnapshotRect;
       
        CGRect lblPlaceRect;
        CGRect lblCategorytitleRect;
        CGRect lblCreateByRect;
        CGRect imgViewiconRect;
        CGRect lblViewcountRect;
        CGRect imgAvatarRect;
        
        CGRect imgcommentIConRect;
        CGRect lblcommentCountRect;
        
        CGRect imgLoveiconRect;
        CGRect lblLoveCountRect;
       
        CGRect btnLoveRect;
        CGRect imgShareIconRect;
        
        CGRect shareLiveStreamBtnRect;
       
     

       // frame = CGRectMake(0, 0, cWidth, 400);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            fontSize = 13.0 * scy;
            imgSnapshotRect = CGRectMake(5*scx, 70* scy, cWidth - (10*scx), cHeight - cHeight/(2.5));
            imgAvatarRect = CGRectMake(5*scx, 10* scy, 40*scx, 40 * scy);
            
            lblPlaceRect = CGRectMake(2*scx, imgSnapshotRect.size.height - (20* scy) , imgSnapshotRect.size.width - (4*scx), 20* scy);
            lblCategorytitleRect = CGRectMake(60*scx,imgAvatarRect.size.height/2 + (10* scy) , 100*scx, 20* scy);
            lblCreateByRect = CGRectMake(60*scx , imgAvatarRect.size.height/2 - (10* scy) , cWidth - (32*scx), 20* scy);
            
            imgViewiconRect = CGRectMake(10*scx, self.bounds.size.height - (35* scy) , 20*scx, 20* scy);
            lblViewcountRect = CGRectMake(35*scx, self.bounds.size.height - (35* scy), 40*scx, 20* scy);
            imgcommentIConRect = CGRectMake(80*scx , self.bounds.size.height - (35* scy) ,20*scx, 20* scy);
            lblcommentCountRect = CGRectMake(105*scx , self.bounds.size.height - (35* scy),40*scx, 20* scy);
            imgLoveiconRect = CGRectMake(150*scx, self.bounds.size.height - (35* scy), 20*scx , 20* scy);
            lblLoveCountRect = CGRectMake(175*scx, self.bounds.size.height - (35* scy) , 40*scx, 20* scy);
            
            shareLiveStreamBtnRect = CGRectMake(0*scx, 0* scy, 30*scx, 30* scy);
            
            
            btnLoveRect = CGRectMake(self.bounds.size.width - (50*scx),10* scy,40*scx,40* scy);
            imgShareIconRect = CGRectMake(self.bounds.size.width - (40*scx), self.bounds.size.height - (40* scy) , 25*scx , 25* scy);


        
        } else {
            fontSize = 13.0;
            imgSnapshotRect = CGRectMake(5, 70, cWidth - 10, cHeight - cHeight/2.5);
            imgAvatarRect = CGRectMake(5, 10, 40, 40 );

            lblPlaceRect = CGRectMake(2, imgSnapshotRect.size.height - 20 , imgSnapshotRect.size.width - 4, 20);
            lblCategorytitleRect = CGRectMake(60,imgAvatarRect.size.height/2 + 10 , 100, 20);
            lblCreateByRect = CGRectMake(60 , imgAvatarRect.size.height/2 - 10 , cWidth - 32, 20);
            
            imgViewiconRect = CGRectMake(10, self.bounds.size.height - 35 , 20, 20);
            lblViewcountRect = CGRectMake(35, self.bounds.size.height - 35, 40, 20);
            imgcommentIConRect = CGRectMake(80 , self.bounds.size.height - 35 ,20, 20);
            lblcommentCountRect = CGRectMake(105 , self.bounds.size.height - 35,40, 20);
            imgLoveiconRect = CGRectMake(150, self.bounds.size.height - 35, 20 , 20);
            lblLoveCountRect = CGRectMake(175, self.bounds.size.height - 35 , 40, 20);
            
            shareLiveStreamBtnRect = CGRectMake(0, 0, 30, 30);
            
            
            btnLoveRect = CGRectMake(self.bounds.size.width - 50,10,40,40);
            imgShareIconRect = CGRectMake(self.bounds.size.width - 40, self.bounds.size.height - 40 , 25 , 25);

        }
//        NSLog(@"cHeight ::: %f",cHeight);
    
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        self.imgAvatar = [[UIImageView alloc] initWithFrame:imgAvatarRect];
        self.imgAvatar.contentMode = UIViewContentModeScaleAspectFill;
        self.imgAvatar.layer.cornerRadius = imgAvatarRect.size.width/2 ;
        self.imgAvatar.clipsToBounds = TRUE;
        [self.contentView addSubview:self.imgAvatar];
        
        self.imgSnapshot = [[UIImageView alloc] initWithFrame:imgSnapshotRect];
        self.imgSnapshot.contentMode = UIViewContentModeScaleToFill;
        self.imgSnapshot.layer.cornerRadius = 5 ;
        self.imgSnapshot.clipsToBounds = TRUE;
        //[self generateWarterMark];
        
      //  [self.contentView setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:self.imgSnapshot];
//        [self.contentView setFrame:(CGRect){ .size = [UIScreen mainScreen].bounds.size.width/2 - 20,500 }];
        
        
        self.lblPlace = [[UILabel alloc] initWithFrame:lblPlaceRect];
        self.lblPlace.font = font;
        self.lblPlace.textColor = [UIColor whiteColor];
        [self.imgSnapshot addSubview:self.lblPlace];
        
        self.lblCategoryTitle = [[UILabel alloc] initWithFrame:lblCategorytitleRect];
        self.lblCategoryTitle.font = font;
        self.lblCategoryTitle.text = @"Category :";
        self.lblCategoryTitle.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.lblCategoryTitle];
        
         self.btnCreatbyName = [[UIButton alloc] initWithFrame:lblCreateByRect];
         self.lblCreateBy = [[UILabel alloc] initWithFrame:self.btnCreatbyName.bounds];
         self.lblCreateBy.font = [UIFont fontWithName:@"Helvetica" size:fontSize + 4];
         self.lblCreateBy.textColor = [UIColor blackColor];
        [self.btnCreatbyName addSubview: self.lblCreateBy];
        [self.contentView addSubview:self.btnCreatbyName];
        
        self.shareLivestream = [[UIButton alloc] initWithFrame:imgShareIconRect];
        [self.shareLivestream setBackgroundColor:[UIColor clearColor]];
        [self.shareLivestream setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.shareLivestream];

        
        self.imgViewicon = [[UIImageView alloc] initWithFrame:imgViewiconRect];
        self.imgViewicon.image = [UIImage imageNamed:@"view.png"];
        [self.contentView addSubview:self.imgViewicon];
        
        self.lblViewCount = [[UILabel alloc] initWithFrame:lblViewcountRect];
        self.lblViewCount.font = font;
        self.lblViewCount.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.lblViewCount];
        
        self.lblcommentCount = [[UILabel alloc] initWithFrame:lblcommentCountRect];
        self.lblcommentCount.font = font;
         self.lblcommentCount.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.lblcommentCount];
        
        self.commentLivebtn = [[UIButton alloc] initWithFrame:imgcommentIConRect];
        UIImageView *imgcomment = [[UIImageView alloc] initWithFrame:self.commentLivebtn.bounds];
        imgcomment.image = [UIImage imageNamed:@"massege.png"];
        [self.commentLivebtn addSubview:imgcomment];
        [self.contentView addSubview:self.commentLivebtn];
        
         self.btnLoveicon = [[UIButton alloc] initWithFrame:btnLoveRect];
         self.btnLoveicon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
         self.btnLoveicon.contentMode = UIViewContentModeScaleAspectFit;
         [self.btnLoveicon setImage:[UIImage imageNamed:@"ic_love.png"] forState:UIControlStateNormal];
         [self.contentView addSubview:self.btnLoveicon];
        
//        [self.btnLoveicon addTarget:self action:(sss)forControlEvents:UIControlEventTouchUpInside];
//      
        self.imgLoveicon = [[UIImageView alloc] initWithFrame:imgLoveiconRect];
        self.imgLoveicon.image = [UIImage imageNamed:@"love11.png"];
        [self.contentView addSubview:self.imgLoveicon];
       
        
        self.lblLoveCount = [[UILabel alloc] initWithFrame:lblLoveCountRect];
        self.lblLoveCount.font = font;
        self.lblLoveCount.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.lblLoveCount];
        
//        [self setHighlighted:NO];
//        [self setSelected:NO animated:NO];
//        ;
        
        
   }
    
    return self;
}

- (void)generateWarterMark {
    
    CGRect imgFrame = self.imgSnapshot.bounds;
    CGFloat imgHeight;
    //UIImage *playBig = [UIImage imageNamed:@"VKVideoPlayer_play_big.png"];
   
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        imgHeight = 50.0 * (768.0/360.0);
    } else {
        imgHeight = 50.0;
    }
    
    
   UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((imgFrame.size.width/2) - (imgHeight/2), (imgFrame.size.height/2)-(imgHeight/2), imgHeight, imgHeight)];
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

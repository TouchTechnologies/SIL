//
//  LiveStreamingCell.m
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 3/8/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//


#import "LiveStreamingCell.h"
#import <KKGridView/KKGridView.h>
#import "AppDelegate.h"

@implementation LiveStreamingCell
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
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        
        //        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        //        self.backgroundView.backgroundColor = [UIColor redColor];
        //        [self addSubview: self.backgroundView];
        CGFloat cWidth = self.bounds.size.width;
        CGFloat cHeight = self.bounds.size.height;
        
        
        CGFloat fontSize;
        
        CGRect imgSnapshotRect;
        
        CGRect lblPlaceRect;
        CGRect lblCreateDescRect;
        CGRect lblCreateByRect;
        CGRect imgViewiconRect;
        CGRect lblViewcountRect;
        CGRect lblViewRect;
        
        CGRect imgLoveiconRect;
        CGRect lblLoveCountRect;
        CGRect lblLoveRect;
        
        CGRect shareLiveStreamBtnRect;
        
        
        
        // frame = CGRectMake(0, 0, cWidth, 400);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            fontSize = 13.0 * scx;
            imgSnapshotRect = CGRectMake(0, 0, cWidth, cHeight/2 + (30 * scy));
            
            lblPlaceRect = CGRectMake(2*scx, imgSnapshotRect.size.height +(1*scy) , cWidth - (2*scx), 20*scy);
            lblCreateDescRect = CGRectMake(2*scx,imgSnapshotRect.size.height +(22*scy) , 30*scx, 20*scy);
            lblCreateByRect = CGRectMake(30*scx, imgSnapshotRect.size.height +(22*scy) , cWidth - (32*scx), 20*scy);
            
            
            imgViewiconRect = CGRectMake(2*scx, cHeight/2 + (76*scy) , 20*scx, 20*scy);
            lblViewcountRect = CGRectMake(30*scx, cHeight/2 + (76*scy) , 50*scx, 20*scy);
            lblViewRect = CGRectMake(80*scx, cHeight/2 + (76*scy) , cWidth - (32*scx), 20* scy);
            
            imgLoveiconRect = CGRectMake(2*scx, imgSnapshotRect.size.height + (64*scy), 20*scx,20*scy);
            lblLoveCountRect = CGRectMake(30*scx,imgSnapshotRect.size.height +(64*scy) , 50*scx, 20*scy);
            lblLoveRect = CGRectMake(80*scx, imgSnapshotRect.size.height +(64*scy), cWidth - (32*scx), 20*scy);
            
            shareLiveStreamBtnRect = CGRectMake(0, 0, 30*scx, 30*scy);
            
            
        } else {
            fontSize = 13.0;
            imgSnapshotRect = CGRectMake(0, 0, cWidth, cHeight - cHeight/3);
            lblPlaceRect = CGRectMake(2, imgSnapshotRect.size.height +1 , cWidth - 2, 20);
            lblCreateDescRect = CGRectMake(2,imgSnapshotRect.size.height +22 , 30, 20);
            lblCreateByRect = CGRectMake(30, imgSnapshotRect.size.height +22 , cWidth - 32, 20);
            imgViewiconRect = CGRectMake(2, imgSnapshotRect.size.height + 43 , 20, 20);
            lblViewcountRect = CGRectMake(30, imgSnapshotRect.size.height +43 , 50, 20);
            lblViewRect = CGRectMake(80, imgSnapshotRect.size.height +43, cWidth - 32, 20);
            
            shareLiveStreamBtnRect = CGRectMake(0, 0, 30, 30);
            
            imgLoveiconRect = CGRectMake(2, imgSnapshotRect.size.height +64 , 20, 20);
            lblLoveCountRect = CGRectMake(30,imgSnapshotRect.size.height +64 , 50, 20);
            lblLoveRect = CGRectMake(80, imgSnapshotRect.size.height +64, cWidth - 32, 20);
            
        }
//        NSLog(@"cHeight ::: %f",cHeight);
        
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        
        self.imgSnapshot = [[UIImageView alloc] initWithFrame:imgSnapshotRect];
        self.imgSnapshot.contentMode = UIViewContentModeScaleToFill;
        //[self generateWarterMark];
        
        //  [self.contentView setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:self.imgSnapshot];
        //        [self.contentView setFrame:(CGRect){ .size = [UIScreen mainScreen].bounds.size.width/2 - 20,500 }];
        
        
        self.lblPlace = [[UILabel alloc] initWithFrame:lblPlaceRect];
        self.lblPlace.font = font;
        [self.contentView addSubview:self.lblPlace];
        
        self.lblCreateDesc = [[UILabel alloc] initWithFrame:lblCreateDescRect];
        self.lblCreateDesc.font = font;
        self.lblCreateDesc.text = @"By :";
        [self.contentView addSubview:self.lblCreateDesc];
        
        self.btnCreatbyName = [[UIButton alloc] initWithFrame:lblCreateByRect];
        self.lblCreateBy = [[UILabel alloc] initWithFrame:self.btnCreatbyName.bounds];
        self.lblCreateBy.font = font;
        self.lblCreateBy.textColor = [UIColor blueColor];
        [self.btnCreatbyName addSubview: self.lblCreateBy];
        [self.contentView addSubview:self.btnCreatbyName];
        
//        self.shareLivestream = [[UIButton alloc] initWithFrame:shareLiveStreamBtnRect];
//        [self.shareLivestream setBackgroundColor:[UIColor whiteColor]];
//        [self.shareLivestream setBackgroundImage:[UIImage imageNamed:@"ic_share21.png"] forState:UIControlStateNormal];
//        [self.contentView addSubview:self.shareLivestream];
        
        
        self.imgViewicon = [[UIImageView alloc] initWithFrame:imgViewiconRect];
        self.imgViewicon.image = [UIImage imageNamed:@"ic_alertcomplant.png"];
        [self.contentView addSubview:self.imgViewicon];
        
        self.lblViewCount = [[UILabel alloc] initWithFrame:lblViewcountRect];
        self.lblViewCount.font = font;
        self.lblViewCount.textColor = [UIColor blueColor];
        [self.contentView addSubview:self.lblViewCount];
        
        self.lblView = [[UILabel alloc] initWithFrame:lblViewRect];
        self.lblView.text = @" View";
        self.lblView.font = font;
        [self.contentView addSubview:self.lblView];
        
        self.btnLoveicon = [[UIButton alloc] initWithFrame:imgLoveiconRect];
        // [self.btnLoveicon addTarget:self action:(sss)forControlEvents:UIControlEventTouchUpInside];
        UIImageView *img = [[UIImageView alloc] initWithFrame:self.btnLoveicon.bounds];
        img.image = [UIImage imageNamed:@"ic_love.png"];
        [self.btnLoveicon addSubview:img];
        [self.contentView addSubview:self.btnLoveicon];
        
        self.lblLoveCount = [[UILabel alloc] initWithFrame:lblLoveCountRect];
        self.lblLoveCount.font = font;
        self.lblLoveCount.textColor = [UIColor blueColor];
        [self.contentView addSubview:self.lblLoveCount];
        
        self.lblLove = [[UILabel alloc] initWithFrame:lblLoveRect];
        self.lblLove.text = @" Love";
        self.lblLove.font = font;
        [self.contentView addSubview:self.lblLove];
        
        
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
    imgView.image = [UIImage imageNamed:@"VKVideoPlayer_play_big.png"];
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


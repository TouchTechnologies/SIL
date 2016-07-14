//
//  VideoListViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 6/18/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoPlace.h"
#import "VideoCell.h"
#import "VideoDetailViewController.h"
#import "VideoDetailTableViewController.h"

#import "defs.h"
#import "AFNetworking.h"
#import "ROI.h"
#import "CCTVS.h"
#import "DataManager.h"
#import "Haneke.h"
#import "UIImage+HanekeDemo.h"
#import "MBProgressHUD.h"
#import <Google/Analytics.h>
#import "ModelManager.h"
#include "AppDelegate.h"
#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

static NSString *CellIdentifier = @"CellIdentifier";

@interface VideoListViewController () {
    
    CGFloat headCellHeight;
    CGFloat cellHeight;
    CGFloat imgX;
    CGFloat imgY;
    CGFloat kImgWidth;
    CGFloat kImgHeight;
    CGFloat fontSize;
    CGFloat lblFontW;
    CGFloat lblTitleX;
    
    CGFloat lblDistance;
    CGFloat lblView;
    CGFloat ImgDistance;
    CGFloat ImgView;
    
    CGRect lblTitleRect;
    CGRect lblDistanceRect;
    CGRect lblViewRect;
    CGRect ImgDistanceRect;
    CGRect ImgViewRect;
}
@property (nonatomic) NSArray *roiArr;
@property (nonatomic) NSString *loadingTitle;
@end

@implementation VideoListViewController

+ (void)initialize {
    /*
    HNKCacheFormat *format = [[HNKCacheFormat alloc] initWithName:@"thumbnailList"];
    
    format.compressionQuality = 100;
    // UIImageView category default: 0.75, -[HNKCacheFormat initWithName:] default: 1.
    
    format.allowUpscaling = YES;
    // UIImageView category default: YES, -[HNKCacheFormat initWithName:] default: NO.
    
    //format.diskCapacity = 10 * 1024 * 1024;
    format.diskCapacity = 0;

    // UIImageView category default: 10 * 1024 * 1024 (10MB), -[HNKCacheFormat initWithName:] default: 0 (no disk cache).
    
    format.preloadPolicy = HNKPreloadPolicyNone;
    // Default: HNKPreloadPolicyNone,HNKPreloadPolicyLastSession,HNKPreloadPolicyAll
    
    format.scaleMode = HNKScaleModeNone;
    // UIImageView category default: -[UIImageView contentMode], -[HNKCacheFormat initWithName:] default: HNKScaleModeFill. HNKScaleModeAspectFill
    
    format.size = CGSizeMake(kImgWidth, kImgHeight);
    // UIImageView category default: -[UIImageView bounds].size, -[HNKCacheFormat initWithName:] default: CGSizeZero.
    
    
    format.preResizeBlock = ^UIImage* (NSString *key, UIImage *image) {
        
        CGSize newSize = CGSizeMake(kImgWidth, kImgHeight);
        UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    
    };
    
    format.postResizeBlock = ^UIImage* (NSString *key, UIImage *image) {
        
        CGSize newSize = CGSizeMake(kImgWidth, kImgHeight);
        UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        
        
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
     
        //NSString *title = [key.lastPathComponent stringByDeletingPathExtension];
        //title = [title stringByReplacingOccurrencesOfString:@"sample" withString:@""];
        //UIImage *modifiedImage = [image demo_imageByDrawingColoredText:title];
        //return modifiedImage;
     
    };
    
    
    [[HNKCache sharedCache] registerFormat:format];
    */
}

-(id)init {
    self = [super init];
    if(self ) {
      
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tblViewVideo registerClass:[VideoCell class] forCellReuseIdentifier:CellIdentifier];
    // Do any additional setup after loading the view.
    self.loadingTitle = @"Loading ...";
    
    [self initialSize];
    [self initialData];
    NSLog(@"Video List");
    //[self loadJSON];

}

- (void)initialSize {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        headCellHeight = 30.0 * SCALING_Y;
        cellHeight = 120.0 * SCALING_Y;
        imgX = 15.0 * SCALING_X;
        imgY = 5.0 * SCALING_Y;
        kImgWidth = 140.0 * SCALING_X;
        kImgHeight = 100.0 * SCALING_Y;
        fontSize = 14.0 * SCALING_X;
        lblFontW = 190.0 * SCALING_X;
        lblTitleX = 165.0 * SCALING_X;
        
        lblDistance = 220.0 * SCALING_X;
        lblView = 220.0 * SCALING_X;
        ImgDistance = 180.0 * SCALING_X;
        ImgView = 180.0 * SCALING_X;
        
     
        

        
        
    } else {
        
        headCellHeight = 30.0;
        cellHeight = 120.0;
        imgX = 15.0;
        imgY = 5.0;
        kImgWidth = 140.0;
        kImgHeight = 100.0;
        fontSize = 14.0;
        lblFontW = 190.0;
        lblTitleX = 165.0;
        
        lblDistance = 220.0;
        lblView = 220.0;
        ImgDistance = 180.0;
        ImgView = 180.0;
        
    }
}

- (void)initialData {
    
    // Show progress
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading...";
//    [hud show:YES];
    
    //Set the background color
    self.tblViewVideo.backgroundColor = [UIColor whiteColor]; //[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];
    self.tblViewVideo.backgroundView = nil;
    
    
    
    self.vdoList = [[NSArray alloc] init];
    self.placeSection = [[NSArray alloc] init];
    
    __weak VideoListViewController *weakSelf = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[DataManager shareManager] getCCTVwithCompletionBlockDatabase:^(BOOL success, NSArray *roiRecords, NSError *error) {
        //        [hud hide:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (success) {
            NSLog(@"before weakSelf.vdoList count  %lu",(unsigned long)weakSelf.vdoList.count);
            ModelManager *modelManager=[ModelManager getInstance];
            //            weakSelf.vdoList = [modelManager getAllDataSort];
            NSArray *sortedArray  = [modelManager getAllData];
            NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
            //            NSSortDescriptor *secondDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            
            NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
            
            weakSelf.vdoList = [sortedArray sortedArrayUsingDescriptors:sortDescriptors];
            
            [weakSelf.tblViewVideo reloadData];
        }
        
    }];


    
                
//    [[DataManager shareManager] getCCTVwithCompletionBlock:^(BOOL success, NSArray *roiRecords, NSError *error) {
//        [hud hide:YES];
//        if (success) {
//            
//            weakSelf.vdoList = roiRecords;
//        } else {
//            //self.loadingTitle = @"Network issue try again";
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        [weakSelf.tblViewVideo reloadData];
//       /*
//        NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:weakSelf.tblViewVideo]);
//        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
//        [weakSelf.tblViewVideo reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
//        */
//    }];
    
    
    
    
    //NSLog(@"test test");
    
    //NSLog(@"%@",self.vdoSectionList);
    
}

- (void)loadJSON {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return self.placeSection.count;
    //NSInteger count = self.vdoList.count ? self.vdoList.count : 1;
    return self.vdoList.count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //return [self.placeSection objectAtIndex:section];
    //NSString *secTitle = @"";
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    ROI *roi = [self.vdoList objectAtIndex:section];
    NSString *secTitle = roi.roiName;
    
    /*
    if (self.vdoList.count) {
        ROI *roi = [self.vdoList objectAtIndex:section];
        secTitle = roi.roiName;
        
    }
     */
    /*
    else {
        secTitle = self.loadingTitle;
    }
    */
    return secTitle;
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ROI *roi = [self.vdoList objectAtIndex:section];
    NSInteger count = roi.cctvs.count;
    
    //return [[self.vdoSectionList objectAtIndex:section] count];
    //ROI *roi = [self.vdoList objectAtIndex:section];
    //return roi.cctvs.count;
    /*
    NSInteger count = 1;
    
    if (self.vdoList.count) {
        ROI *roi = [self.vdoList objectAtIndex:section];
        count = roi.cctvs.count;
    } else {
        count = 1;
    }
    */
    return count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    NSInteger count = self.vdoList.count ? headCellHeight: 0;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSInteger count = self.vdoList.count ? 20: 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = nil;
    
    //if (self.vdoList.count) {
        //static NSString *simpleTableIdentifier = @"VideoCell";
        //VideoCell *vdoCell = (VideoCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

   VideoCell *vdoCell = (VideoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
        /*
        if (vdoCell == nil) {
            //NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"VideoCell" owner:self options:nil];
            //vdoCell = [nibArray objectAtIndex:0];
            //vdoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
         */
    
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    
    
        ROI *roi = [self.vdoList objectAtIndex:[indexPath section]];
        CCTVS *cctvs = [roi.cctvs objectAtIndex:[indexPath row]];
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    NSString *strPoint = cctvs.cctvName;
    CGRect frame = [strPoint boundingRectWithSize:CGSizeMake(vdoCell.frame.size.width - lblFontW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
   CGFloat scy =  (1024.0/480.0);
   CGFloat scx = (768.0/360.0);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    vdoCell.lblTitle.frame = CGRectMake(lblTitleX, (vdoCell.frame.size.height /2) - (frame.size.height/2+(30*scy)), frame.size.width, frame.size.height);
    vdoCell.lblDistance.frame = CGRectMake(lblDistance, vdoCell.frame.size.height- (60*scy), vdoCell.frame.size.width, vdoCell.frame.size.height);
    vdoCell.lblView.frame = CGRectMake(lblDistance,  vdoCell.frame.size.height - (35*scy), vdoCell.frame.size.width, vdoCell.frame.size.height);
    vdoCell.ImgDistance.frame = CGRectMake(lblTitleX, vdoCell.frame.size.height- (65*scy) , 25*scx, 25*scy);
    vdoCell.ImgView.frame = CGRectMake(lblTitleX, vdoCell.frame.size.height - (40*scy), 25*scx, 25*scy);
    }
    
    else{
     vdoCell.lblTitle.frame = CGRectMake(lblTitleX, (vdoCell.frame.size.height /2) - (frame.size.height/2+30), frame.size.width, frame.size.height);
      vdoCell.lblDistance.frame = CGRectMake(lblDistance, vdoCell.frame.size.height- 60, vdoCell.frame.size.width, vdoCell.frame.size.height);
      vdoCell.lblView.frame = CGRectMake(lblDistance,  vdoCell.frame.size.height - 35, vdoCell.frame.size.width, vdoCell.frame.size.height);
     vdoCell.ImgDistance.frame = CGRectMake(lblTitleX, vdoCell.frame.size.height- 65 , 25, 25);
     vdoCell.ImgView.frame = CGRectMake(lblTitleX, vdoCell.frame.size.height - 40, 25, 25);
        
    }
    vdoCell.lblTitle.text = strPoint;
    vdoCell.lblTitle.font = font;
    [vdoCell.lblTitle sizeToFit];

    vdoCell.lblDistance.text = [NSString stringWithFormat:@"%.02f%@",cctvs.distance,@"  km."];
    vdoCell.lblDistance.font = font;
    [vdoCell.lblDistance sizeToFit];
 
    vdoCell.lblView.text = [self addComma:cctvs.totalView];
    vdoCell.lblView.font = font;
    [vdoCell.lblView sizeToFit];
    
    vdoCell.ImgDistance.image = [UIImage imageNamed:@"icon_H1.png"];
    
    vdoCell.ImgView.image = [UIImage imageNamed:@"ic_alertcomplant.png"];
    vdoCell.imgVideo.frame = CGRectMake(imgX, imgY, kImgWidth, kImgHeight);
    
    UIImage *imgPH = [self resizeImage:[UIImage imageNamed:@"sil_small.jpg"] imageSize:CGSizeMake(kImgWidth, kImgHeight)];
    
    
    HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnail"];
    if (!format)
    {
        format.compressionQuality = 100;
        format.allowUpscaling = YES;
        format.diskCapacity = 0;
        format.preloadPolicy = HNKPreloadPolicyNone;
        format.scaleMode = HNKScaleModeNone;
        format.size = CGSizeMake(kImgWidth, kImgHeight);
        
        format.preResizeBlock = ^UIImage* (NSString *key, UIImage *image) {
            
            CGSize newSize = CGSizeMake(kImgWidth, kImgHeight);
            UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
            [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return newImage;
            
        };
        
        format.postResizeBlock = ^UIImage* (NSString *key, UIImage *image) {
            
            CGSize newSize = CGSizeMake(kImgWidth, kImgHeight);
            UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
            [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return newImage;
        };
        
    }
    
    vdoCell.imgVideo.hnk_cacheFormat = format;
    
        //vdoCell.imageView.hnk_cacheFormat = [HNKCache sharedCache].formats[@"thumbnailList"];
        NSURL *url = [NSURL URLWithString:cctvs.imageUrl];
        [vdoCell.imgVideo hnk_setImageFromURL:url placeholder:imgPH];
        vdoCell.imgVideo.contentMode = UIViewContentModeScaleToFill;
        //[vdoCell.imageView.image demo_imageByCroppingRect:CGRectMake(0, 0, 136, 76)];
        
        //vdoCell.contentMode = UIViewContentModeScaleAspectFit;
        //vdoCell.clipsToBounds = YES;

        
        //cell = vdoCell;
    /*
    } else {
        UITableViewCell *loadingCell = [tableView dequeueReusableCellWithIdentifier:@"LoadingCellId"];
        UILabel *statusLabel = (UILabel *)[loadingCell.contentView viewWithTag:111];
        statusLabel.text = self.loadingTitle;
        cell = loadingCell;
    }
    */

    
    return vdoCell;
    


}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]])
    {
        UITableViewHeaderFooterView *castView = (UITableViewHeaderFooterView *) view;
        UIView *content = castView.contentView;
        
        UIColor *color = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];; // substitute your color here
        content.backgroundColor = color;
        
        CGRect sepFrame = CGRectMake(0, content.frame.size.height-1, content.frame.size.width, 1);
        UIView *seperatorView = [[UIView alloc] initWithFrame:sepFrame];
        seperatorView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        [content addSubview:seperatorView];
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:content.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(10.0, 10.0)];
        
        CAShapeLayer *markLayer = [[CAShapeLayer alloc] init];
        markLayer.frame = content.bounds;
        markLayer.path = shadowPath.CGPath;
        content.layer.mask = markLayer;
        
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        
        castView.textLabel.font = font;
        
    }
}

/*
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]])
    {
        UITableViewHeaderFooterView *castView = (UITableViewHeaderFooterView *) view;
        UIView *content = castView.contentView;
        UIColor *color = [UIColor whiteColor]; // substitute your color here
        content.backgroundColor = color;
        

        //[castView.textLabel setTextColor:[UIColor blackColor]];
    }
}
*/
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    ROI *roi = [self.vdoList objectAtIndex:section];
    NSString *secTitle = roi.roiName;
    lblTitle.text = secTitle;
    lblTitle.font = font;
    
    return lblTitle;
}
*/

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, tableView.bounds.size.width, 20);
    //footerView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];
    footerView.backgroundColor = [UIColor whiteColor];
    /*
    CGRect sepFrame = CGRectMake(0, 0, tableView.bounds.size.width, 1);
    UIView *seperatorView = [[UIView alloc] initWithFrame:sepFrame];
    seperatorView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [footerView addSubview:seperatorView];
    
    UIButton *button = [[UIButton alloc] init];
    [button setFrame:CGRectMake(0, 1, tableView.bounds.size.width, 40)];
    [button setTitle:@"More" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [footerView addSubview:button];
    self.tblViewVideo.tableFooterView.contentMode = UIViewContentModeScaleToFill;
    
    UIView *footerLine = [[UIView alloc] init];
    footerLine.frame = CGRectMake(0, 20, tableView.bounds.size.width, 20);
    footerLine.backgroundColor = [UIColor whiteColor];
    
    [footerView addSubview:footerLine];
    */
    
    return footerView;
}

#pragma mark UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoDetailViewController *vdoDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"videodetail"];
    
    
    
    //[self presentViewController:vdoDetail animated:TRUE completion:nil];
    
    /*
    VideoDetailTableViewController *vdoTblDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"videotabledetail"];
    
    [self presentViewController:vdoTblDetail animated:TRUE completion:nil];
    */
    ROI *roi = [self.vdoList objectAtIndex:[indexPath section]];
    vdoDetail.roi = roi;
    vdoDetail.rowIndex = [indexPath row];
    [self.navigationController pushViewController:vdoDetail animated:TRUE];
    //NSLog(@"%ld",(long)indexPath.row);
    
}

-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
    
}

-(NSString*)addComma:(NSString *)number
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
    
    
    NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:[number integerValue]]];
    return formatted;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
 UIRectCorner corners = 0;
 if (tableView.style == UITableViewStyleGrouped) {
 if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
 corners = UIRectCornerAllCorners;
 } else if (indexPath.row == 0) {
 corners = UIRectCornerTopLeft | UIRectCornerTopRight;
 } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
 corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
 }
 }
 
 [cell configureFlatCellWithColor:[UIColor greenSeaColor]
 selectedColor:[UIColor cloudsColor]
 roundingCorners:corners];
 
 cell.cornerRadius = 5.f; //Optional
 if (self.tblViewVideo.style == UITableViewStyleGrouped) {
 cell.separatorHeight = 2.f; //Optional
 } else {
 cell.separatorHeight = 0.;
 }
 */

/*
 VideoPlace *vdoPlace = (VideoPlace *)[[self.vdoSectionList objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
 cell.lblTitle.text = vdoPlace.place;
 cell.lblDetail.text = vdoPlace.timeArrive;
 cell.imgVideo.image = [UIImage imageNamed:vdoPlace.imageName];
 */
//NSURL *url = [NSURL URLWithString:ServerApiURL];
//self.vdoList = [NSMutableArray array];
/*
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 [manager GET:ServerApiURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
 //NSLog(@"JSON: %@", responseObject);
 NSArray *response = (NSArray *)responseObject;
 //NSDictionary
 //NSMutableArray *recordObjects = [NSMutableArray array];
 
 
 for (NSDictionary *roiRecord in response) {
 ROI *roi = [[ROI alloc] init];
 roi.roiName = roiRecord[@"provider_information_tag_name"];
 
 NSMutableArray *cctvObjects = [NSMutableArray array];
 for (NSDictionary *cctvRecord in roiRecord[@"cctvs"]) {
 CCTVS *cctvs = [[CCTVS alloc] init];
 cctvs.cctvName = cctvRecord[@"label_en"];
 cctvs.imageUrl = cctvRecord[@"live_url"];
 cctvs.latitude = cctvRecord[@"latitude"];
 cctvs.longitude = cctvRecord[@"longitude"];
 cctvs.timeCreate = cctvRecord[@"created"];
 
 [cctvObjects addObject:cctvs];
 }
 
 roi.cctvs = [NSArray arrayWithArray:cctvObjects];
 
 [self.vdoList addObject:roi];
 }
 */
//self.placeSection = [NSArray arrayWithArray:self.vdoList];
//[self.tblViewVideo reloadData];
/*
 NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:self.tblViewVideo]);
 NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
 
 [self.tblViewVideo reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
 */
//NSArray *cctv = [response valueForKey:@"cctvs"];
/*
 for (ROI *roi in self.vdoList) {
 NSLog(@"roi: %@", roi.roiName);
 for (CCTVS *cctvs in roi.cctvs) {
 NSLog(@"- %@",cctvs.cctvName);
 NSLog(@"- %@",cctvs.imageUrl);
 }
 }
 */
//NSLog(@"JSON: %@", self.vdoList.count);
//NSLog(@"JSON: %@", cctv);

/*
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 NSLog(@"Error: %@", error);
 }];
 */

/*
 self.placeSection = @[@"Pattaya",@"Huahin",@"Chaam"];
 self.vdoList = [[NSMutableArray alloc] init];
 self.vdoSectionList = [[NSMutableArray alloc] init];
 
 VideoPlace *vdoPlace = [[VideoPlace alloc] init];
 vdoPlace.city = @"Pattaya";
 vdoPlace.place = @"Bali Hai"; //Jomtien,Naklua
 vdoPlace.imageName = @"image1.jpg";
 vdoPlace.timeArrive = @"28 sec ago";
 [self.vdoList addObject:vdoPlace];
 
 vdoPlace = [[VideoPlace alloc] init];
 vdoPlace.city = @"Pattaya"; //Huahin,Chaam
 vdoPlace.place = @"Jomtien";
 vdoPlace.imageName = @"image2.jpg";
 vdoPlace.timeArrive = @"28 sec ago";
 [self.vdoList addObject:vdoPlace];
 
 vdoPlace = [[VideoPlace alloc] init];
 vdoPlace.city = @"Pattaya";
 vdoPlace.place = @"Naklua";
 vdoPlace.imageName = @"image3.jpg";
 vdoPlace.timeArrive = @"28 sec ago";
 [self.vdoList addObject:vdoPlace];
 
 vdoPlace = [[VideoPlace alloc] init];
 vdoPlace.city = @"Huahin"; //Huahin,Chaam
 vdoPlace.place = @"Bali Hai 2"; //Jomtien,Naklua
 vdoPlace.imageName = @"image4.jpg";
 vdoPlace.timeArrive = @"28 sec ago";
 [self.vdoList addObject:vdoPlace];
 
 vdoPlace = [[VideoPlace alloc] init];
 vdoPlace.city = @"Huahin"; //Huahin,Chaam
 vdoPlace.place = @"Jomtien 2";
 vdoPlace.imageName = @"image5.jpg";
 vdoPlace.timeArrive = @"28 sec ago";
 [self.vdoList addObject:vdoPlace];
 
 vdoPlace = [[VideoPlace alloc] init];
 vdoPlace.city = @"Huahin";
 vdoPlace.place = @"Naklua 2";
 vdoPlace.imageName = @"image6.jpg";
 vdoPlace.timeArrive = @"28 sec ago";
 [self.vdoList addObject:vdoPlace];
 
 vdoPlace = [[VideoPlace alloc] init];
 vdoPlace.city = @"Chaam"; //Huahin,Chaam
 vdoPlace.place = @"Bali Hai 3"; //Jomtien,Naklua
 vdoPlace.imageName = @"activities02.jpg";
 vdoPlace.timeArrive = @"28 sec ago";
 [self.vdoList addObject:vdoPlace];
 
 vdoPlace = [[VideoPlace alloc] init];
 vdoPlace.city = @"Chaam"; //Huahin,Chaam
 vdoPlace.place = @"Jomtien 3";
 vdoPlace.imageName = @"image3.jpg";
 vdoPlace.timeArrive = @"28 sec ago";
 [self.vdoList addObject:vdoPlace];
 
 vdoPlace = [[VideoPlace alloc] init];
 vdoPlace.city = @"Chaam";
 vdoPlace.place = @"Naklua 3";
 vdoPlace.imageName = @"image6.jpg";
 vdoPlace.timeArrive = @"28 sec ago";
 [self.vdoList addObject:vdoPlace];
 
 for (NSString *city in self.placeSection) {
 NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(city == %@)",city];
 //NSMutableArray *placeByCityList = [[NSMutableArray alloc] init];
 //placeByCityList = [[self.vdoList filteredArrayUsingPredicate:predicate] mutableCopy];
 NSArray *placeByCityList = [self.vdoList filteredArrayUsingPredicate:predicate];
 [self.vdoSectionList addObject:placeByCityList];
 }
 */
@end

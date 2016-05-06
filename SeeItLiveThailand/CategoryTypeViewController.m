//
//  CategoryTypeViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 4/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "CategoryTypeViewController.h"
#import "CategoryListViewController.h"
#import "Streaming.h"
#import "DataManager.h"

@interface CategoryTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    UITableViewCell *cell;

    UIView *bgCellView;
    UIImageView *imgCategory;
    UILabel *lblCategoryType;
    UILabel *lblLivevideo;
    UILabel *lblLivevideoCount;
    
    
    //Rect//
    CGRect tableviewRect;
    CGRect bgCellViewRect;
    CGRect imgCategoryRect;
    CGRect lblCategoryTypeRect;
    CGRect lblLivevideoRect;
    CGRect lblLivevideoCountRect;
    
    //Float//
    CGFloat cellH;
    CGFloat fontSize;
    
    NSArray *iconCate;
    NSArray *lblCateType;
    
    Streaming *stream;
    
    NSString *cateCount;
    
}
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic,strong) NSDictionary *iconcategory;
@end

@implementation CategoryTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSize];
    [self initial];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];

    // Do any additional setup after loading the view.
}
-(void)initialSize{
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    
    }
    else{
        cellH = 80;
        fontSize = 14;
        tableviewRect =CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 120);
        bgCellViewRect = CGRectMake(5, 5 , width - 10 , cellH - 10);
        imgCategoryRect = CGRectMake(10, bgCellViewRect.size.height/2 - 25, 60, 60) ;
        lblCategoryTypeRect = CGRectMake(imgCategoryRect.origin.x + imgCategoryRect.size.width + 10 , bgCellViewRect.size.height/2 - 20, width - lblCategoryTypeRect.origin.x , 20);
        lblLivevideoRect = CGRectMake(imgCategoryRect.origin.x + imgCategoryRect.size.width + 10 ,  bgCellViewRect.size.height/2 + 5, 70, 20);
        lblLivevideoCountRect = CGRectMake(lblLivevideoRect.origin.x + lblLivevideoRect.size.width , bgCellViewRect.size.height/2 + 5, 100, 20);
    
    }


}
- (void)viewWillAppear:(BOOL)animated{

    __weak CategoryTypeViewController *weakSelf = self;
    
    
    [[DataManager shareManager] getStreamingWithCompletionBlock:^(BOOL success, NSArray *streamRecords, NSError *error) {
        
        
              if (success) {
        
            weakSelf.streamList = streamRecords;
            NSLog(@"STREAMLIST COUNT :::: %ld", weakSelf.streamList.count);
                  stream =  [weakSelf.streamList objectAtIndex:stream.categoryID];
                  
                  
                  
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not connect" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            /*
             CGFloat xLbl = (weakSelf.view.bounds.size.width / 2) - 100;
             UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(xLbl, 20, 200, 25)];
             lblTitle.text = NotConnect;
             lblTitle.textAlignment = NSTextAlignmentCenter;
             [weakSelf.view addSubview:lblTitle];
             */
            //NSLog(@"%@",error);
        }

    }];
    


}
- (void)initial
{
    iconCate = [NSArray arrayWithObjects:@"travel.png",@"culture1.png"
                @"event.png", @"news.png", @"lifestyle.png",@"other.png",@"Music.png", nil];
    lblCateType = [NSArray arrayWithObjects:@"Travel",@"Culture",@"Event",@"News",@"Lifestyle",@"Other",@"Music", nil];
   
    tableview = [[UITableView alloc] initWithFrame:tableviewRect];
    tableview.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    tableview.bounces = NO;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableview registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return iconCate.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     CategoryListViewController *category = [self.storyboard instantiateViewControllerWithIdentifier:@"categorylist"];
    [self.view.window.rootViewController presentViewController:category animated:TRUE completion:nil];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
  //  stream.categoryID = [self.streamList objectAtIndex:[indexPath row]];
    NSLog(@"CATEGORY ID:::%@", stream.categoryID );
    
   
    bgCellView = [[UIView alloc] initWithFrame:bgCellViewRect];
    bgCellView.backgroundColor = [UIColor whiteColor];
    bgCellView.layer.borderWidth = 1;
    bgCellView.layer.borderColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.0].CGColor;
    [cell.contentView addSubview:bgCellView];
    
    imgCategory = [[UIImageView alloc] initWithFrame:imgCategoryRect];
    imgCategory.image = [UIImage imageNamed:[iconCate objectAtIndex:[indexPath row]]];
    imgCategory.contentMode = UIViewContentModeScaleAspectFit;
  // imgCategory.layer.cornerRadius = imgCategoryRect.size.height/2;
  //  imgCategory.clipsToBounds = YES;
    [cell.contentView addSubview:imgCategory];
    
    lblCategoryType =[[UILabel alloc] initWithFrame:lblCategoryTypeRect];
    lblCategoryType.text = [lblCateType objectAtIndex:[indexPath row]];
    lblCategoryType.font = [UIFont fontWithName:@"Helvetica" size: fontSize];
    [cell.contentView addSubview:lblCategoryType];
    
    lblLivevideo = [[UILabel alloc] initWithFrame:lblLivevideoRect];
    lblLivevideo.font = [UIFont fontWithName:@"Helvetica" size:fontSize-2];
    lblLivevideo.textColor = [UIColor grayColor];
    lblLivevideo.text = @"Live video : ";
    [cell.contentView addSubview:lblLivevideo];
    
    lblLivevideoCount = [[UILabel alloc] initWithFrame:lblLivevideoCountRect];
    lblLivevideoCount.font = [UIFont fontWithName:@"Helvetica" size:fontSize-2];
    lblLivevideoCount.textColor = [UIColor redColor];
    lblLivevideoCount.text = @"35";
    [cell.contentView addSubview:lblLivevideoCount];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CGFloat rowHeight = self.vdoList.count ? 260 : 100;
    return cellH;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

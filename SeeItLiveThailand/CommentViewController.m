//
//  CommentViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/26/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "CommentViewController.h"
#import "UserManager.h"
#import "AppDelegate.h"
#import "Comment.h"
#import "MBProgressHUD.h"
#import "commentTableViewCell.h"
@interface CommentViewController ()
{
    CGRect tableviewRect;
    CGFloat tblH;
    CGFloat tblW;
    CGRect ImgProfileRect;
    CGRect txtCommentRect;
    CGRect btnSendCommentRect;
    CGRect propViewRect;
    
    CGFloat propViewW;
    CGFloat propViewH;
    
    CGFloat cellH;
    
    
    CGFloat font;
    
    
    IBOutlet UIView *tblView;

    UILabel *commentLbl;
    NSString *comment_type;
    commentTableViewCell *cell;
    Comment *com;

}
- (IBAction)BackBtn:(id)sender;
@property (nonatomic, strong) NSMutableArray *comment;
@property (nonatomic, strong) NSString *userID;
@end

@implementation CommentViewController


- (void)viewDidLoad {
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    self.comment =  [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    [self initialSize];
    [self initial];
   
    
    [_btnSendComment addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    
//    if (self.comment == nil) {
//        self.tableView.hidden = true;
//    
//        UILabel *noCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 , [UIScreen mainScreen].bounds.size.width, 50)];
//        noCommentLabel.textAlignment = NSTextAlignmentCenter ;
//        
//        noCommentLabel.text = @"No Comment";
//        noCommentLabel.font = [UIFont fontWithName:@"System" size:18];
//        noCommentLabel.textColor = [UIColor redColor];
//        [self.view addSubview:noCommentLabel];
  //  }
      //self.tableView.hidden = true;
    // Do any additional setup after loading the view.
}

- (void)initialSize{
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        font = 14*scy;
        propViewW = width;
        propViewH = 70*scy;
        propViewRect = CGRectMake(0, height - propViewH, width, propViewH);
         ImgProfileRect = CGRectMake(4*scx, 8*scy, propViewH - (20*scx), propViewH - (20*scy));
        txtCommentRect = CGRectMake(ImgProfileRect.size.width + 4, 20*scy, 80*scx, 30*scy);
         btnSendCommentRect = CGRectMake(txtCommentRect.size.width + 4, 20*scy, 50*scx, 30*scy);
        
        tblH = height - propViewH;
        tblW = width;
        cellH = 60*scy;
        }
    else{
        font = 14;
        propViewW = width;
        propViewH = 70;
        propViewRect = CGRectMake(0, height - propViewH, width, propViewH);
        
        ImgProfileRect = CGRectMake(4, 8, propViewH - 20, propViewH - 20);
        
        txtCommentRect = CGRectMake(ImgProfileRect.size.width + 8, 20, 100, 30);
        btnSendCommentRect = CGRectMake(txtCommentRect.size.width + 4, 20, 50, 30);
        
        tblH = (self.view.bounds.size.height - propViewH - self.navigationController.navigationBar.bounds.size.height);
        tblW = width;
        cellH = 60 ;
    
    }

}
-(void)initial{
    
    NSLog(@"getcommentAll initial ");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    [hud show:YES];
    [self.comment removeAllObjects];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    comment_type = appDelegate.comment_type;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //    [self.tableView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 80)];
    
    NSString *API_Name = ([comment_type isEqualToString:@"CCTV"])?@"getcommentAll":@"getcommentAllStream";
    [[UserManager shareIntance] commentAPI:API_Name cctvID:appDelegate.CCTV_ID data:nil Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        [hud hide:YES];
        NSLog(@"getcommentAll result %@",result);

        for (NSDictionary *comment in result)
        {
            com = [[Comment alloc] init];
            com.commentMsg = comment[@"comment_content"];
            com.commentPicture = comment[@"commentator"][@"profile_picture"];
            com.commentID = comment[@"id"];
            com.commentName = [comment[@"commentator"][@"first_name"] stringByAppendingFormat:@" %@ :",comment[@"commentator"][@"last_name"]];
//            NSLog(@"commentID %@",com.commentID);
            [self.comment addObject:com];
        }
        NSLog(@"getcommentAll com %@",com);
        [self.tableView reloadData];
    }];
//    [hud hide:YES];
//    for (int i = 0; i < 20 ; i++) {
//        com = [[Comment alloc] init];
//        com = [[Comment alloc] init];
//        com.commentMsg = @"message testt";
//        com.commentPicture = @"";
//        com.commentID = @"1";
//        [self.comment addObject:com];
//    }
    
//
    [self.propertyView setFrame:propViewRect];
    [self.imgProfileView setFrame:ImgProfileRect];
    self.imgProfileView.layer.cornerRadius = _imgProfileView.bounds.size.width/2;
    //self.imgProfileView.backgroundColor = [UIColor blackColor];
    self.imgProfileView.clipsToBounds = TRUE;
//    self.txtCommentText.frame = txtCommentRect;
    self.txtCommentText.layer.cornerRadius =10 ;
    self.txtCommentText.layer.borderWidth = 1 ;
    self.txtCommentText.layer.borderColor = [UIColor grayColor].CGColor;
    if (appDelegate.isLogin) {
           self.imgProfileView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appDelegate.profile_picture]]];
    }
    else{
        self.imgProfileView.image = [UIImage imageNamed:@"ic_new_imgaccount2.png"];
    
    }
 
    
    self.userID = appDelegate.user_ID ;
    NSLog(@"IMAGE PROFILE::: %@",appDelegate.profile_picture);
   
      [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed: 0.22 green:0.47 blue:0.7 alpha:1]];
      
   // [self.navigationController.navigationBar setTitleTextAttributes:(NSDictionary<NSString *,id> * _Nullable)]
//    self.btnSendComment.frame = btnSendCommentRect;
//    self.btnSendComment.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
//    
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.comment.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    
    Comment *comment = [[Comment alloc] init];
//    com = [[Comment alloc] init];
    comment = [self.comment objectAtIndex:[indexPath row]];
    
    UINib *nib = [UINib nibWithNibName:@"commentviewcell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"cell"];
  
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.usercommentImg setFrame:CGRectMake(4, 8, cellH - 16, cellH - 16)];
    cell.usercommentImg.layer.cornerRadius =(cellH - 16)/2;
    cell.usercommentImg.clipsToBounds = TRUE;

    cell.usercommentImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comment.commentPicture]]];
    
    NSString *strCommentWname = [NSString stringWithFormat:@"%@ %@",comment.commentName,comment.commentMsg];
    
    
    [cell.usernameLbl setFrame:CGRectMake(cellH, 2 , [UIScreen mainScreen].bounds.size.width - (cellH), 30)];
    [cell.usernameLbl setText:strCommentWname];
    [cell.usernameLbl setFont:[UIFont fontWithName:@"Helvetica" size:font]];
    cell.usernameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    cell.usernameLbl.numberOfLines = 0 ;
    cell.usernameLbl.textAlignment = NSTextAlignmentJustified;
    [cell.usernameLbl sizeToFit];

    NSString *strPoint = comment.commentMsg;
  //  [cell.commentLbl setFrame:CGRectMake(cellH, 30 , [UIScreen mainScreen].bounds.size.width - (cellH+5), 30)];
    [cell.commentLbl setText:strPoint];
    [cell.commentLbl setFont:[UIFont fontWithName:@"Helvetica" size:font]];
    cell.commentLbl.lineBreakMode = NSLineBreakByWordWrapping;
    cell.commentLbl.numberOfLines = 0 ;
    cell.commentLbl.textAlignment = NSTextAlignmentJustified;
    [cell.commentLbl sizeToFit];

//    cell.usercommentImg = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, cellH - 16, cellH - 16)];
//    cell.usercommentImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:com.commentPicture]]];
//    
//    cell.commentLbl = [[UILabel alloc] init];
//    [cell.commentLbl setFrame:CGRectMake(cellH, 4 , [UIScreen mainScreen].bounds.size.width - (cellH+5), 30)];
//    cell.commentLbl.backgroundColor = [UIColor redColor];
//    
//    NSString *strPoint = com.commentMsg;
//    cell.commentLbl.text = strPoint;
   // NSLog(@"COMMENT COUNT ::: %d",self.comment.count);
    return cell;



    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
////    cell.selectionStyle = UITableViewCellSelectionStyleNone;
////    if([indexPath row] == 2){
////        
////        cell.Img.image = [UIImage imageNamed:@"ic_more_about.png"];
////        cell.textLbl.textColor = [UIColor redColor];
////        
////        [self performSegueWithIdentifier:@"showabout" sender:self];
////    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CGFloat rowHeight = self.vdoList.count ? 260 : 100;
    if (cell.usernameLbl.bounds.size.height  + 20 <= cellH) {
        return cellH;
    }
    else{
    return cell.usernameLbl.bounds.size.height  + 20 ;
    }
}

- (void)addItem:sender {

   
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    if (appDelegate.isLogin) {
        NSLog(@"add comment");
        com = [[Comment alloc] init];
        com.commentMsg = self.txtCommentText.text;
        com.commentPicture = appDelegate.profile_picture;
        NSString *API_Name = ([comment_type isEqualToString:@"CCTV"])?@"postcomment":@"postcommentStream";
        [[UserManager shareIntance] commentAPI:API_Name cctvID:appDelegate.CCTV_ID data:com Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"postcomment %@",result);
            
            // reload data
            [self viewDidLoad];
            
        }];
        
        
        self.txtCommentText.text = @"";
        [self.txtCommentText resignFirstResponder];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Login" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    
    }
    

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    com = [[Comment alloc] init];
    com = [self.comment objectAtIndex:[indexPath row]];
    // Return NO if you do not want the apply specified item to be editable.
    
    if([com.commentPicture isEqualToString:appDelegate.profile_picture]) {// such like indexPath.row == 1,... or whatever.
        return YES;
    }
    else{
        return NO;
    }
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    com = [[Comment alloc] init];
    com = [self.comment objectAtIndex:[indexPath row]];
   // editingStyle = UITableViewCellEditingStyleNone;
    

        if (editingStyle == UITableViewCellEditingStyleDelete)
            {
//                 UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Delete Comment!!!" message:@"" delegate:(nullable id) cancelButtonTitle:(nullable NSString *) otherButtonTitles:(nullable NSString *), ..., nil]
                 NSString *API_Name = ([comment_type isEqualToString:@"CCTV"])?@"delcomment":@"delcommentStream";

                [[UserManager shareIntance] commentAPI:API_Name cctvID:appDelegate.CCTV_ID data:com Completion:^(NSError *error, NSDictionary *result, NSString *message) {
                    NSLog(@"delcomment : %@",result);
                    
                    
                   
                    
                    
                    [self viewDidLoad];
                    //            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
   }
 
//        }
//  else{
//      editingStyle = UITableViewCellEditingStyleNone;
//  }
//    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [self.view setFrame:CGRectMake(0, -keyboardFrameBeginRect.size.height ,width,height)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [self.view setFrame:CGRectMake(0,0,width,height)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

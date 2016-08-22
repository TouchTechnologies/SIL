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
    CGRect commentLblRect;
    CGRect imgUserCommentRect;
    
    CGFloat propViewW;
    CGFloat propViewH;
    
    CGFloat cellH;
    
    
    CGFloat font;
    CGFloat preferredCommentWidth;
    
    IBOutlet UIView *tblView;

    UILabel *commentLbl;
    NSString *comment_type;
 //   commentTableViewCell *cell;
    Comment *com;

}
- (IBAction)BackBtn:(id)sender;
@property (nonatomic, strong) NSMutableArray *comment;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation CommentViewController


- (void)viewDidLoad {
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    self.comment =  [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    [self initialSize];
    [self initial];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [_btnSendComment addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    UINib *nib ;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         nib = [UINib nibWithNibName:@"commentviewcelliPad" bundle:nil];
         
    }
    else{
        nib = [UINib nibWithNibName:@"commentviewcell" bundle:nil];
    }
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
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
        font = 16 ;
        propViewW = width;
        propViewH = 70*scy;
            cellH = 100*scy ;
        preferredCommentWidth = width - (80*scy);
        propViewRect = CGRectMake(0, height - propViewH, width, propViewH);
        
        imgUserCommentRect =CGRectMake(10*scx,10*scy,propViewH - (30*scx), propViewH - (30*scy));
        commentLblRect = CGRectMake(60*scx, 8*scy , [UIScreen mainScreen].bounds.size.width - (cellH +(10*scx)), font+2);
        
        ImgProfileRect = CGRectMake(20, propViewH/2 - 32.5,65, 65);
        txtCommentRect = CGRectMake(ImgProfileRect.size.width + (5*scx), 20*scy, 80*scx, 30*scy);
         btnSendCommentRect = CGRectMake(txtCommentRect.size.width + 4, 20*scy, 50*scx, 30*scy);
        
        tblH = height - propViewH;
        tblW = width;
        }
    else{
        font = 14;
        propViewW = width;
        propViewH = 70;
        cellH = 40 ;
        preferredCommentWidth = width - 80;
        propViewRect = CGRectMake(0, height - propViewH, width, propViewH);
        
        imgUserCommentRect =CGRectMake(10, 10, 50 ,  50 );
        commentLblRect = CGRectMake(60 , 8 , [UIScreen mainScreen].bounds.size.width - (cellH+10), font+2);
        
        ImgProfileRect = CGRectMake(10, propViewH/2 - 25,50, 50);
        txtCommentRect = CGRectMake(ImgProfileRect.size.width + 5, 5, width-70, 30);
        btnSendCommentRect = CGRectMake(txtCommentRect.size.width + 4, 20, 50, 30);
        
        tblH = (self.view.bounds.size.height - propViewH - self.navigationController.navigationBar.bounds.size.height);
        tblW = width;
       
    
    }

}
-(void)viewDidAppear:(BOOL)animated{
    
  
}
-(void)initial{
   
    NSLog(@"getcommentAll initial ");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    [hud show:YES];
//
    [self.comment removeAllObjects];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    comment_type = appDelegate.comment_type;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//
//    
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
            [self.comment addObject:com];
        }
        
        NSLog(@"getcommentAll com %@",com);
        [self.tableView reloadData];
    }];
    


    
      // bottom view //
    [self.propertyView setFrame:propViewRect];
    [self.imgProfileView setFrame:ImgProfileRect];
    self.imgProfileView.layer.cornerRadius = _imgProfileView.bounds.size.width/2;
    self.imgProfileView.clipsToBounds = TRUE;
    self.txtCommentText.font = [UIFont fontWithName:@"Helvetica" size:font];
    self.txtCommentText.layer.cornerRadius =10 ;
    self.txtCommentText.layer.borderWidth = 1 ;
    self.txtCommentText.layer.borderColor = [UIColor grayColor].CGColor;
    self.btnSendComment.layer.cornerRadius = 5;
    self.btnSendComment.clipsToBounds = TRUE;
    if (appDelegate.isLogin) {
           self.imgProfileView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appDelegate.profile_picture]]];
    }
    else{
        self.imgProfileView.image = [UIImage imageNamed:@"ic_new_imgaccount2.png"];
    
    }
 
    
    self.userID = appDelegate.user_ID ;
    NSLog(@"IMAGE PROFILE::: %@",appDelegate.profile_picture);
   
      [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed: 0.22 green:0.47 blue:0.7 alpha:1]];
    
}


# pragma mark - Cell Setup

- (void)setUpCell:(commentTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Comment *comment = [[Comment alloc] init];
    comment = [self.comment objectAtIndex:[indexPath row]];
    NSLog(@"comment ARR %@",comment);
 
    cell.usercommentImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.usercommentImg.layer.borderWidth = 1;
   
     [cell.usernameLbl setFont:[UIFont fontWithName:@"Helvetica" size:font]];
    [cell.commentLbl setFont:[UIFont fontWithName:@"Helvetica" size:font]];
     cell.commentLbl.preferredMaxLayoutWidth = preferredCommentWidth;

 //   NSString *strCommentWname = [NSString stringWithFormat:@"%@ %@",comment.commentName,comment.commentMsg];
    if (comment.commentPicture != NULL) {
            cell.usercommentImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comment.commentPicture]]];
    }
    else{
        cell.usercommentImg.image = [UIImage imageNamed:@"anonymous.png"];
    }
    
    cell.usernameLbl.text = comment.commentName;
    cell.commentLbl.text = comment.commentMsg;

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.comment.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  commentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  [self setUpCell:cell atIndexPath:indexPath];
    return cell;
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static commentTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    });
    
    [self setUpCell:cell atIndexPath:indexPath];
    
    return [self calculateHeightForConfiguredSizingCell:cell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"SIZE CELL ::: %f",size.height);
    return size.height;

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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 100;
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

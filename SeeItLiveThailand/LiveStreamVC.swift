//
//  LiveStreamVC.swift
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 12/22/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import CoreLocation
//import SocketIOClientSwift


class LiveStreamVC: UIViewController,VCSessionDelegate,CustomIOS7AlertViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource
{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var socket:SocketIOClient? = nil;
    let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
    var countDown:NSInteger = 0;
    var countDownTimer = NSTimer()
    var timerValue = 20
    var comments = NSMutableArray()
    //    @IBOutlet var previewView: UIView!
    @IBOutlet var connectBtn: UIButton!
    
    
    
    var streamView:UIView?
    var popUpView:UIView?
    var popUpViewTop:UIView?
    var popUpViewBot:UIView?
    var popUpViewCen:UIView?
    var popUpViewRight:UIView?
    var popUpViewLeft:UIView?
    var popUpViewChat:UIView?
    
    
    var tableView : UITableView?
    
    
    var streamButton:UIButton?
    var startStreamBtn:UIButton?
    var stopStreamBtn:UIButton?
    var closeBtn:UIButton?
    var changeCamBtn:UIButton?
    var flashBtn:UIButton?
    
    var commentScroll:UIScrollView?
    var commentText:UITextView?
    var commentProfileImage:UIImage?
    var commentProfileName:UITextView?
    
    var topCenView:UIView?
    var titleIconImg:UIImageView?
    var titleLbl:UILabel?
    var locationName:NSString?
    var titleTxt:UITextField?
    
    var selectCatLbl:UILabel?
    var categoryTxt:UITextField?
    var selectCatBtn:UIButton?
    var categoryPickerView:UIPickerView?
    //    var catArray : [String] = ["Other","Travel","Education","Event","News"]
    var catID = 1
//    var count = 0
    var qualityLbl:UILabel?
    var qualityTxt:UITextField?
    var selectQualityBtn:UIButton?
    var shareBtn:UIButton?
    var shareFBBtn : FBSDKShareButton = FBSDKShareButton()
    var qualityPickerView:UIPickerView?
    var qualityArray : [String] = ["High","Medium","Low"]
    var countDownLbl:UILabel?
    var locationPinImg : UIImageView?
    var locationLbl : UILabel?
    
    var slider:UISlider?
    // These number values represent each slider position
    var numbers = [1, 2, 3, 4, 5, 6,7,8,9,10,11,12,13,14,15,16,17,18,19,20] //Add your values here
    var oldIndex = 0
    
    var detailLiveLbl : UILabel?
    var timeDetail : UILabel?
    
    
    var streamURL:String?
    var streamKey:String?
    var StreamName:String?
    
    let recordBar = UIView()
    var rcGrapY = CGFloat()
    var rcBarH = CGFloat()
    var rcButtonW = CGFloat()
    let cameraManager = CameraManager()
    
    //chat tableview cell
    var imgUserChat = UIImageView()
    var lblUserName = UILabel()
    var lblTextChat = UILabel()
    
    var imgUserChatRect = CGRect()
    var lblUserNameRect = CGRect()
    var lblTextChatRect = CGRect()
    
    
    //ojc top view
    var locateLbl = UILabel()
    var locateImg = UIImageView()
    var lovecountLbl = UILabel()
    var loveiconImg = UIImageView()
    var viewcountLbl = UILabel()
    var viewiconImg = UIImageView()
    var titletopLbl = UILabel()
    var liveiconImg = UIImageView()
    
    // obj bot view
    @IBOutlet var chatBtn : UIButton?
    @IBOutlet var shareLiveBtn : UIButton?
    var shareListView = UIView()
    @IBOutlet var facebookBtn : UIButton?
    @IBOutlet var googleBtn : UIButton?
    @IBOutlet var tweeterBtn : UIButton?
    @IBOutlet var linekBtn : UIButton?
    @IBOutlet var copyLinkBtn : UIButton?
    
    
    
    
    //rect
    
    
    var topCenViewRect = CGRect()
    var titleIconImgRect = CGRect()
    var titleLblRect = CGRect()
    var titleTxtRect = CGRect()
    var selectCatLblRect = CGRect()
    var categoryTxtRect = CGRect()
    var selectCatBtnRect = CGRect()
    var qualityLblRect = CGRect()
    var qualityTxtRect = CGRect()
    var countDownRect = CGRect()
    var selectQualityBtnRect = CGRect()
    var locationPinImgRect = CGRect()
    var locationLblRect = CGRect()
    var detailLiveLblRect = CGRect()
    var timeDetailRect = CGRect()
    var shareBtnRect = CGRect()
    var shareFBBtnRect = CGRect()
    var font = CGFloat()
    var categoryPickerViewRect = CGRect()
    var qualityPickerViewRect = CGRect()
    var streamViewRect = CGRect()
    var popUpViewRect = CGRect()
    var popUpViewTopRect = CGRect()
    var popUpViewBotRect = CGRect()
    var popUpViewRightRect = CGRect()
    var popUpViewLeftRect = CGRect()
    var popUpViewCenRect = CGRect()
    var popUpViewChatRect = CGRect()
    
    // rect top
    var locateLblRect = CGRect()
    var locateImgRect = CGRect()
    var lovecountLblRect = CGRect()
    var loveiconImgRect = CGRect()
    var viewcountLblRect = CGRect()
    var viewiconImgRect = CGRect()
    var titletopLblRect = CGRect()
    var liveiconImgRect = CGRect()
    
    
    // obj bot view Rect
    var chatBtnRect = CGRect()
    var shareLiveBtnRect = CGRect()
    var shareListViewRect = CGRect()
    var facebookBtnRect = CGRect()
    var googleBtnRect = CGRect()
    var tweeterBtnRect = CGRect()
    var linekBtnRect = CGRect()
    var copyLinkBtnRect = CGRect()
    
    var sliderRect = CGRect()
    var changeCamBtnRect = CGRect()
    var flashBtnRect = CGRect()
    
    var closeBtnRect = CGRect()
    var streamButtonRect = CGRect()
    var startStreamBtnRect = CGRect()
    
    var cellH = CGFloat()
    var fonttitle = CGFloat()
    var session:VCSimpleSession = VCSimpleSession(videoSize: CGSize(width: 1920, height: 1080), frameRate: 30, bitrate: 1000000, useInterfaceOrientation: false, cameraState: VCCameraState.Back , aspectMode:VCAspectMode.AspectModeFit)
    //    var session:VCSimpleSession = VCSimpleSession()
    
    
    //    var alertView = CustomIOS7AlertView()
    var popupView = UIView()
    //    var popup = popupStream()
    var liveBtn = UIButton()
    var textButton = UILabel()
    //  @IBOutlet weak var stopBtn: UIButton!
    
    var alertView = UIView()
    var alertViewRect = CGRect()
    
    var alertTitleLbl = UILabel()
    var alertTitleLblRect = CGRect()
    
    var subAlertTitleLbl = UILabel()
    var subAlertTitleLblRect = CGRect()
    
    var okBtnAlert = UIButton()
    var okBtnAlertRect = CGRect()
    
    var cancelBtnAlert = UIButton()
    var cancelBtnAlertRect = CGRect()
    
    var timeStreamLbl = UILabel()
    var titimeStreamLblRect = CGRect()
    
    var countdownImg = UIImageView()
    var countdownImgRect = CGRect()
    
    var countdownLbl = UILabel()
    var countDownLblRect = CGRect()
    var countdownLblFontsize = CGFloat()
    var count = 5
    //var timecount = 5.00
    var chatplaceView = UIView()
    var  objChatLbl = UILabel()
    
    
    func stopStream(sender: UIButton) {

        print("Stop Streaming")
        self.countDownTimer.invalidate()
        if(session.rtmpSessionState == .Started)
        {
            session.endRtmpSession()
        }
        
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }

    func startStream(sender:UIButton){
        
        self.timeStreamLbl.text = String(timeFormatted(self.timerValue))
        
        self.popUpViewTop!.hidden = false
        self.popUpViewBot!.hidden = false
        countdownLbl.hidden = false;
        self.chatBtn?.hidden = false
        //self.shareLiveBtn?.hidden = false
        
        print("getQualityStream \(getQualityStream(qualityTxt!.text!))")
        print("qualityLbl!.text! \(qualityTxt!.text!)")
        print("GO Streaming")


        //popUpViewTop!.hidden = true
        popUpViewCen!.hidden  = true
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateTime: String = formatter.stringFromDate(NSDate())
        
        
        //        alertView.close()
        //        self.previewView.addSubview(stopBtn)
        
        switch session.rtmpSessionState {
        case .None, .PreviewStarted, .Ended, .Error:
            // session.startRtmpSessionWithURL("rtmp://10.49.0.107:1935/pon", andStreamKey: "myStream")  Name+Sur_2016_01_31
            let stream = UserManager()
            let title:String = (titleTxt!.text != "" ) ? titleTxt!.text! : "\(appDelegate.first_name) \(appDelegate.last_name)_\(appDelegate.date)"
            print("Title : \(title) Category ID : \(catID)")
            stream.getStreamURL(title,categoryID: catID, note: "",dateTime: dateTime) { (error , result , message) in
            
                print("result stream \(result)")
                print("message stream \(message)")
                print("SnapShot : \(result["snapshots"]!["800x600"]! as! String)")
                self.content.contentURL = NSURL(string: result["web_url"] as! String)
                self.content.contentTitle = result["title"] as! String
//                self.content.contentDescription = "<INSERT STRING HERE>"
//                self.content.imageURL = NSURL(string: result["snapshots"]!["800x600"]! as! String)
                self.shareFBBtn.shareContent = self.content
                self.popUpViewBot!.addSubview(self.shareFBBtn)
                
                if(error != nil)
                {
                    print("Error : \(error)")
                }else{
                    print("Error : \(error)")
                    print("message : \(message)")
                    print("data : \(result["urls"]!["rtmp"]!)")
                    self.streamURL = (result["urls"]!["rtmp"] as! String)
                    print("streamURLALL :\(self.streamURL)")
                    print("StreamID : \(result["id"])")
                    let key = self.streamURL?.characters.split{$0 == "/"}.map(String.init)
                    print("AllKey : \(key)")
                    self.streamKey = key![3]
                    self.streamURL = self.streamURL!.stringByReplacingOccurrencesOfString("/\(self.streamKey!)", withString: "")
                    print("StreamURL : \(self.streamURL!)")
                    print("Key : \(self.streamKey!)")
                    
                    self.titletopLbl.text = (result["title"] as! String)
                    self.setSocketLive(result["id"] as! Int)
                    self.session.useAdaptiveBitrate = true ///Adaptive Bit Rate Enable
                    self.session.startRtmpSessionWithURL(self.streamURL!, andStreamKey: self.streamKey!)

                    
                    
                }
                
            }
            
//            session.startRtmpSessionWithURL("rtmp://192.168.9.111:1935/live", andStreamKey: "stream")
            //        session.startRtmpSessionWithURL("rtmp://streaming.touch-ics.com:1935/live", andStreamKey: "myStream")
            
        default:
            //            self.dismissViewControllerAnimated(true, completion: nil)
            //            self.presentationController.dis

            
                
                
            print("Stop Streaming")
            alertView = UIView(frame: alertViewRect)
            alertView.backgroundColor = UIColor.whiteColor()
            alertView.layer.cornerRadius = 10
            alertView.alpha = 0.7
            popUpView!.addSubview(alertView)
            
            alertTitleLbl = UILabel(frame:alertTitleLblRect)
            alertTitleLbl.textAlignment = .Center
            alertTitleLbl.text = "Stop streaming?"
            alertTitleLbl.font = UIFont.init(name: "Helvetica", size: font)
            alertView.addSubview(alertTitleLbl)
            
            startStreamBtn?.enabled = false
            okBtnAlert = UIButton(frame:okBtnAlertRect)
            let okLbl = UILabel(frame:okBtnAlert.bounds)
            okLbl.text = "OK"
            okLbl.font = UIFont.init(name: "Helvetica", size: font)
            okLbl.textAlignment = .Center
            okBtnAlert.addSubview(okLbl)
            okBtnAlert.backgroundColor = UIColor.clearColor()
            okBtnAlert.layer.cornerRadius = 5
            okBtnAlert.layer.borderWidth = 1
            okBtnAlert.layer.borderColor = UIColor.lightGrayColor().CGColor
            okBtnAlert.addTarget(self, action:  #selector(LiveStreamVC.okStop(_:)), forControlEvents:  UIControlEvents.TouchUpInside)
            alertView.addSubview(okBtnAlert)
            
            cancelBtnAlert = UIButton(frame:cancelBtnAlertRect)
            let cancelLbl = UILabel(frame:okBtnAlert.bounds)
            cancelLbl.text = "CANCEL"
            cancelLbl.font = UIFont.init(name: "Helvetica", size: font)
            cancelLbl.textAlignment = .Center
            cancelBtnAlert.addSubview(cancelLbl)
            cancelBtnAlert.backgroundColor = UIColor.clearColor()
            cancelBtnAlert.layer.cornerRadius = 5
            cancelBtnAlert.layer.borderWidth = 1
            cancelBtnAlert.layer.borderColor = UIColor.lightGrayColor().CGColor
            cancelBtnAlert.addTarget(self, action: #selector(LiveStreamVC.cancelStop(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            alertView.addSubview(cancelBtnAlert)
            
          
        
            break
        }
        //        print("Stop Streaming")
        //        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func cancelStop(sender :UIButton){
        startStreamBtn?.enabled = true
        alertView.hidden = true;
    }
    func okStop(sender :UIButton){
        
        self.countDownTimer.invalidate()
        timerValue = 0;
        alertView.hidden = true;
        print("Stop Streaming")
        if(session.rtmpSessionState == .Started)
        {
            session.endRtmpSession()
        }
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        self.timePlus()
        appDelegate.isChat = false
        appDelegate.isShare = false
        self.timerValue = getStreamTime()
        self.timeStreamLbl.text = String(timeFormatted(self.timerValue))
//        self.initSocket()
        self.initialSize()
        self.initial()
        self.getLocationName()
        catID = Int(appDelegate.categoryData[0]["id"] as! String)!
       
//        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(LiveStreamVC.update), userInfo: nil, repeats: true)
 
        print("IS CHAT didload ::: \(appDelegate.isChat) ")
        //self.initSocket()
        
        //        slider = UISlider(frame: self.view.bounds)
        //        self.view.addSubview(slider!)
        
        // slider values go from 0 to the number of values in your numbers array
        //        var numberOfSteps = Float(numbers.count - 1)
        slider!.maximumValue = 20;
        slider!.minimumValue = 0;
        
        slider!.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        // As the slider moves it will continously call the -valueChanged:
        slider!.continuous = true; // false makes it call only once you let go
        slider!.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LiveStreamVC.dismissKeyboard))
        self.view!.addGestureRecognizer(tap)
        //popUpViewCen!.addGestureRecognizer(tap)
        
        //        fullView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] applicationFrame].size.width,[[UIScreen mainScreen] applicationFrame].size.height+100)];

        self.session.previewView.frame = streamView!.frame
        streamView!.backgroundColor = UIColor.blueColor()
        self.session.delegate = self
        self.streamView!.addSubview(session.previewView)
        
        self.session.orientationLocked = false
        
        
        //        self.previewView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        // self.previewView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        //        alertView.show()
        //hide keyboard alert
        //        let tapV: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //        self.view!.addGestureRecognizer(tapV)
        //        alertView.addGestureRecognizer(tap)
        
        
        
        
        
    }
    
    func initial(){
        
        
        streamView = UIView(frame: streamViewRect)
        popUpView = UIView(frame: popUpViewRect)
        popUpViewTop = UIView(frame: popUpViewTopRect)
        popUpViewTop!.backgroundColor = UIColor.blackColor()
        popUpViewTop!.alpha = 0.7
        locateLbl = UILabel(frame: locateLblRect)
        locateLbl.text = self.appDelegate.locationName
        locateLbl.textColor = UIColor.whiteColor()
        locateLbl.font = UIFont(name: "Helvetica" , size: font - 2)
        popUpViewTop!.addSubview(locateLbl)
        locateLbl.text = "No Location found!"
        
        locateImg = UIImageView(frame : locateImgRect)
        locateImg.image = UIImage(named:"pin_2.png")
        popUpViewTop!.addSubview(locateImg)
        
        lovecountLbl = UILabel(frame: lovecountLblRect)
        lovecountLbl.text = "0"
        lovecountLbl.textColor = UIColor.whiteColor()
        lovecountLbl.font = UIFont(name: "Helvetica" , size: font)
        popUpViewTop!.addSubview(lovecountLbl)
        
        loveiconImg = UIImageView(frame :  loveiconImgRect)
        loveiconImg.image = UIImage(named:"love_noti.png")
        popUpViewTop!.addSubview(loveiconImg)
        
        viewcountLbl = UILabel(frame: viewcountLblRect)
        viewcountLbl.text = "0"
        viewcountLbl.textColor = UIColor.whiteColor()
        viewcountLbl.font = UIFont(name: "Helvetica" , size: font)
        popUpViewTop!.addSubview(viewcountLbl)
        
        viewiconImg = UIImageView(frame :  viewiconImgRect)
        viewiconImg.image = UIImage(named:"view_2.png")
        popUpViewTop!.addSubview(viewiconImg)
        
        liveiconImg  = UIImageView(frame :  liveiconImgRect)
        var imgListArray : [UIImage] = []
        for countValue in 1...2
        {
            
            let strImageName : String = "live\(countValue).png"
           // let image  = UIImage(named:strImageName)
            imgListArray.append(UIImage(named:strImageName)!)
           // imgListArray.addObject(image!)
        }
        liveiconImg.animationImages = imgListArray
        liveiconImg.animationDuration = 1.0
        liveiconImg.startAnimating()
        popUpViewTop!.addSubview(liveiconImg)
        
        titletopLbl  = UILabel(frame: titletopLblRect)
        titletopLbl.text = "LIVE"
        titletopLbl.textColor = UIColor.whiteColor()
        titletopLbl.font = UIFont(name: "Helvetica" , size: fonttitle )
        popUpViewTop!.addSubview(titletopLbl)
        
        
        
        popUpViewBot = UIView(frame: popUpViewBotRect)
        popUpViewBot!.backgroundColor = UIColor.clearColor()
        
        chatBtn = UIButton(frame : chatBtnRect)
        chatBtn!.setImage(UIImage(named: "chat.png"), forState: UIControlState.Normal)
        chatBtn!.addTarget(self, action: #selector(LiveStreamVC.startChat(_:)), forControlEvents: .TouchUpInside)
        popUpViewBot!.addSubview(chatBtn!)
        
        shareLiveBtn = UIButton(frame : shareLiveBtnRect)
        shareLiveBtn!.setImage(UIImage(named: "share_2.png"), forState: UIControlState.Normal)
        shareLiveBtn!.addTarget(self, action: #selector(LiveStreamVC.startShare(_:)), forControlEvents: .TouchUpInside)
        shareLiveBtn!.enabled = false;
        shareLiveBtn!.hidden = true ;
        popUpViewBot!.addSubview(shareLiveBtn!)
        
        shareListView = UIView(frame : shareListViewRect)
        shareListView.backgroundColor = UIColor.clearColor()
        popUpViewBot!.addSubview(shareListView)
        shareListView.hidden = true
        
        facebookBtn = UIButton(frame : facebookBtnRect)
        facebookBtn!.layer.cornerRadius = facebookBtnRect.size.width/2
        facebookBtn!.clipsToBounds = true
        facebookBtn!.backgroundColor = UIColor.grayColor()
        shareListView.addSubview(facebookBtn!)
        
        googleBtn = UIButton(frame : googleBtnRect)
        googleBtn!.layer.cornerRadius = googleBtnRect.size.width/2
        googleBtn!.clipsToBounds = true
        googleBtn!.backgroundColor = UIColor.grayColor()
        shareListView.addSubview(googleBtn!)
        
        tweeterBtn = UIButton(frame : tweeterBtnRect)
        tweeterBtn!.layer.cornerRadius = tweeterBtnRect.size.width/2
        tweeterBtn!.clipsToBounds = true
        tweeterBtn!.backgroundColor = UIColor.grayColor()
        shareListView.addSubview(tweeterBtn!)
        
        linekBtn = UIButton(frame : linekBtnRect)
        linekBtn!.layer.cornerRadius = linekBtnRect.size.width/2
        linekBtn!.clipsToBounds = true
        linekBtn!.backgroundColor = UIColor.grayColor()
        shareListView.addSubview(linekBtn!)
        
        copyLinkBtn = UIButton(frame : copyLinkBtnRect)
        copyLinkBtn!.layer.cornerRadius = copyLinkBtnRect.size.width/2
        copyLinkBtn!.clipsToBounds = true
        copyLinkBtn!.backgroundColor = UIColor.grayColor()
        shareListView.addSubview(copyLinkBtn!)
        
        
//        popUpViewBot?.addSubview(tableView!)
        
        popUpViewChat = UIView(frame : popUpViewChatRect)
        popUpViewChat!.backgroundColor = UIColor.clearColor()
        popUpViewChat!.alpha = 0.7
        popUpViewChat!.layer.cornerRadius = 10
        popUpViewChat!.clipsToBounds = true
        popUpView!.addSubview(popUpViewChat!)
        popUpViewChat!.hidden = false
        
        tableView = UITableView(frame: popUpViewChat!.bounds)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView!.backgroundColor = UIColor.clearColor()
        
        popUpViewChat!.addSubview(tableView!)
        
        
        //        commentScroll?.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.height-200, 150)
        //        commentScroll?.backgroundColor = UIColor.blueColor()
        //        commentScroll?.showsVerticalScrollIndicator = true
        //        commentScroll?.scrollEnabled = true
        //        commentScroll?.userInteractionEnabled = true
        
        //        popUpViewBot?.addSubview(commentScroll!)
        
        
        
        popUpViewRight = UIView(frame: popUpViewRightRect)
        popUpViewLeft = UIView(frame: popUpViewLeftRect)
        
        popUpViewLeft!.backgroundColor = UIColor.clearColor()
        popUpViewRight!.backgroundColor = UIColor.clearColor()
        
        //        popUpViewLeft!.backgroundColor = UIColor.redColor()
        
        
        let popUpViewCenX:CGFloat = UIScreen.mainScreen().bounds.size.height/1.7
        let popUpViewCenY:CGFloat = UIScreen.mainScreen().bounds.size.width/1.6
        
        print("popUpViewCenY ::: \(popUpViewCenY)");
        
        popUpViewCen = UIView(frame: popUpViewCenRect)
        popUpViewCen!.backgroundColor = UIColor.blackColor()
        popUpViewCen!.layer.cornerRadius = 10
        popUpViewCen!.alpha = 0.7
        
        
        slider = UISlider(frame: sliderRect)
        changeCamBtn = UIButton(frame : changeCamBtnRect)
        flashBtn = UIButton(frame :flashBtnRect)
        
        
        changeCamBtn!.setImage(UIImage(named: "ic_flip_camera.png"), forState: .Normal)
        changeCamBtn!.addTarget(self, action: "changeCameraDevice:", forControlEvents: .TouchUpInside)

        flashBtn!.setImage(UIImage(named: "ic_flash2.png"), forState: .Normal)
        flashBtn!.addTarget(self, action: "toggleFlash:", forControlEvents: .TouchUpInside)
        
        
        popUpViewLeft!.addSubview(slider!)
        
        topCenView = UIView(frame: topCenViewRect)
        topCenView!.backgroundColor = UIColor.whiteColor()
        topCenView!.layer.cornerRadius = 5
        
        
        titleIconImg = UIImageView(frame: titleIconImgRect)
        titleIconImg!.image = UIImage(named: "icon_title.png")
        //titleIconImg!.frame =
        //        labelImg!.backgroundColor = UIColor.purpleColor()
        
        titleLbl = UILabel(frame: titleLblRect)
        titleLbl!.text = "Title :"
        titleLbl!.textColor = UIColor .grayColor()
        titleLbl!.font = UIFont.systemFontOfSize(font)
        //titleLbl!.frame =
        //        labelLbl!.backgroundColor = UIColor.purpleColor()
        
        titleTxt = UITextField(frame: titleTxtRect)
        titleTxt!.text = ""
        titleTxt!.font = UIFont.systemFontOfSize(font)
        //titleTxt!.frame =
        
        selectCatLbl = UILabel(frame: selectCatLblRect)
        selectCatLbl!.text = "Select Category"
        selectCatLbl!.textColor = UIColor.whiteColor()
        selectCatLbl!.font = UIFont.boldSystemFontOfSize(font)
        popUpViewCen!.addSubview(selectCatLbl!)
        
        categoryTxt = UITextField(frame: categoryTxtRect)
        categoryTxt!.text = (appDelegate.categoryData[0]["category_name_en"] as! String)
        categoryTxt!.font = UIFont.systemFontOfSize(font)
        categoryTxt!.layer.cornerRadius = 5
        categoryTxt!.clipsToBounds = true
        categoryTxt!.enabled = false
        categoryTxt!.backgroundColor = UIColor.whiteColor()
        popUpViewCen!.addSubview(categoryTxt!)
        
        
        selectCatBtn = UIButton(frame: selectCatBtnRect)
        let img:UIImageView? = UIImageView(frame:selectCatBtn!.bounds)
        img!.image = UIImage(named:"Plus-50.png")
        selectCatBtn!.addSubview(img!)
        selectCatBtn!.backgroundColor = UIColor.clearColor()
        selectCatBtn!.addTarget(self, action: "initialCatPickerView:", forControlEvents: .TouchUpInside)
        popUpViewCen!.addSubview(selectCatBtn!)
        
        
        qualityLbl = UILabel(frame: qualityLblRect)
        qualityLbl!.text = "Select Quality"
        qualityLbl!.textColor = UIColor.whiteColor()
        qualityLbl!.font = UIFont.boldSystemFontOfSize(font)
        //    popUpViewCen!.addSubview(qualityLbl!)
        
        qualityTxt = UITextField(frame: qualityTxtRect)
        qualityTxt!.text = qualityArray[0]
        qualityTxt!.font = UIFont.systemFontOfSize(font)
        qualityTxt!.layer.cornerRadius = 5
        qualityTxt!.clipsToBounds = true
        qualityTxt!.enabled = false
        qualityTxt!.backgroundColor = UIColor.whiteColor()
        //    popUpViewCen!.addSubview(qualityTxt!)
        
        shareBtn = UIButton(frame: shareBtnRect)
        let shareImg:UIImageView? = UIImageView(frame:shareBtn!.bounds)
        shareImg!.image = UIImage(named:"ic_share21.png")
        shareBtn!.addSubview(shareImg!)
        shareBtn!.backgroundColor = UIColor.clearColor()
        shareBtn!.tag = 5
        shareBtn!.addTarget(self, action: #selector(LiveStreamVC.shareMyLive(_:)), forControlEvents: .TouchUpInside)
//        popUpViewBot!.addSubview(shareBtn!)
        
        
        
//        content.contentURL = NSURL(string: "http://www.codingexplorer.com")
//        content.contentTitle = "<INSERT STRING HERE>"
//        content.contentDescription = "<INSERT STRING HERE>"
//        content.imageURL = NSURL(string: "<INSERT STRING HERE>")
//        shareFBBtn.shareContent = content
        shareFBBtn.frame = shareFBBtnRect
//        popUpViewBot!.addSubview(shareFBBtn)
        
        
        
        
        
        selectQualityBtn = UIButton(frame:selectQualityBtnRect)
        let imgQty:UIImageView? = UIImageView(frame:selectCatBtn!.bounds)
        imgQty!.image = UIImage(named:"Plus-50.png")
        selectQualityBtn!.addSubview(imgQty!)
        selectQualityBtn!.backgroundColor = UIColor.clearColor()
        selectQualityBtn!.addTarget(self, action: "initialQualityPickerView:", forControlEvents: .TouchUpInside)
        //    popUpViewCen!.addSubview(selectQualityBtn!)
        
        
        
        categoryPickerView = UIPickerView(frame: categoryPickerViewRect)
        categoryPickerView!.layer.cornerRadius = 5
        categoryPickerView!.delegate = self
        categoryPickerView!.dataSource = self
        categoryPickerView!.backgroundColor = UIColor.whiteColor()
        categoryPickerView!.hidden = true
        popUpViewCen!.addSubview(categoryPickerView!)
        
        
        qualityPickerView = UIPickerView(frame: qualityPickerViewRect)
        qualityPickerView!.layer.cornerRadius = 5
        qualityPickerView!.delegate = self
        qualityPickerView!.dataSource = self
        qualityPickerView!.backgroundColor = UIColor.whiteColor()
        qualityPickerView!.hidden = true
        //    popUpViewCen!.addSubview(qualityPickerView!)
        
        
        
        locationPinImg = UIImageView(frame: locationPinImgRect)
        locationPinImg!.image = UIImage(named: "ic_pin_cctv.png")
        popUpViewCen!.addSubview(locationPinImg!)
        
        locationLbl = UILabel(frame: locationLblRect)
        
        //        if(appDelegate.locationName == nil)
        //        {
        //            print("Location Name \(appDelegate.locationName)")
        locationLbl!.text = "No Location found!"
        //        }else
        //        {
        //            locationLbl!.text = appDelegate.locationName
        //        }
        
        locationLbl!.font = UIFont.systemFontOfSize(font)
        locationLbl!.textColor = UIColor.whiteColor()
        locationLbl!.alpha = 0.5
        popUpViewCen!.addSubview(locationLbl!)
        
        detailLiveLbl = UILabel(frame: detailLiveLblRect)
        detailLiveLbl!.text = "Your account can live with"
        detailLiveLbl!.font = UIFont.systemFontOfSize(font)
        detailLiveLbl!.textColor = UIColor.whiteColor()
        detailLiveLbl!.textAlignment = NSTextAlignment.Right
        detailLiveLbl!.alpha = 0.5
        popUpViewCen!.addSubview(detailLiveLbl!)
        
        timeDetail = UILabel(frame: timeDetailRect)
        timeDetail!.text = "Ulimited"
        timeDetail!.font = UIFont.boldSystemFontOfSize(font)
        timeDetail!.textColor = UIColor.whiteColor()
        popUpViewCen!.addSubview(timeDetail!)
        
        
        
        closeBtn = UIButton(frame: closeBtnRect)
        closeBtn!.setImage(UIImage(named: "ic_action_cancel.png"), forState: .Normal)
        closeBtn!.addTarget(self, action: #selector(LiveStreamVC.stopStream(_:)), forControlEvents: .TouchUpInside)
        //        closeBtn!.backgroundColor = UIColor.blackColor()
        
        streamButton = UIButton(frame: streamButtonRect)
        startStreamBtn = UIButton(frame: startStreamBtnRect)
        
        
        
        
        //  stopStreamBtn = UIButton(frame: CGRectMake(0, 0, 100,100))
        
        
        //        streamButton!.setImage(UIImage(named: "ic_start.png"), forState: .Normal)
        //        streamButton!.frame = CGRectMake(streamView!.frame.size.width - 120 ,streamView!.frame.size.height - 120 ,90, 90)
        
        streamButton!.setImage(UIImage(named: "ic_start.png"), forState: .Normal)
        startStreamBtn!.setTitle("Live", forState: UIControlState.Normal)
        startStreamBtn!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        startStreamBtn!.titleLabel!.textAlignment = NSTextAlignment.Center
        startStreamBtn!.addTarget(self, action: #selector(LiveStreamVC.startStream(_:)), forControlEvents: .TouchUpInside)
        //        startStreamBtn!.addTarget(self, action: "testBtn:", forControlEvents: .TouchUpInside)
        
        
        timeStreamLbl.frame =  titimeStreamLblRect
//        timeStreamLbl.text = "00:00"
        timeStreamLbl.textAlignment = .Center
        timeStreamLbl.textColor = UIColor.whiteColor()
        popUpViewBot!.addSubview(timeStreamLbl)
        
        countdownLbl.frame = countDownRect
     //   countdownLbl.text = "5"
        countdownLbl.font = UIFont.systemFontOfSize(countdownLblFontsize)
        countdownLbl.textColor = UIColor.whiteColor()
      
        
       popUpView?.addSubview(countdownLbl)
      //  popUpVie.addSubview(countdownLbl)
        //countdownLbl.hidden = true;
        
        //        textButton.frame = CGRectMake(0 ,streamButton!.frame.size.height/2-10 ,streamButton!.frame.size.width, 30)
        //        textButton.text = "Starting"
        //        textButton.textAlignment = NSTextAlignment.Center
        //        textButton.font = UIFont.systemFontOfSize(20)
        //        textButton.textColor = UIColor.whiteColor()
        //
        //
        //        streamView!.backgroundColor = UIColor.redColor()
        //        streamView!.alpha = 0.5
        
        
        self.streamButton!.addSubview(textButton)
        
        topCenView!.addSubview(titleIconImg!)
        topCenView!.addSubview(titleLbl!)
        topCenView!.addSubview(titleTxt!)
        self.popUpViewCen!.addSubview(topCenView!)
        
        
       // self.popUpViewBot!.hidden = false;
       // self.chatBtn?.hidden = true
       // self.shareLiveBtn?.hidden = true
        //        self.popUpViewTop?.hidden = true
        
        self.popUpView!.addSubview(popUpViewTop!)
        self.popUpView!.addSubview(popUpViewBot!)
        
        self.popUpViewTop!.addSubview(closeBtn!)
        self.popUpViewBot!.addSubview(streamButton!)
        self.popUpViewBot!.addSubview(startStreamBtn!)
        self.popUpViewRight!.addSubview(changeCamBtn!)
        self.popUpViewRight!.addSubview(flashBtn!)
        
        
        
        
        
        self.popUpView!.addSubview(popUpViewRight!)
        self.popUpView!.addSubview(popUpViewLeft!)
        self.popUpView!.addSubview(popUpViewCen!)
        
        
        
        self.view!.addSubview(streamView!)
        self.view!.addSubview(popUpView!)
        
        
     //  popUpViewTop!.hidden = true
        
        
    }
    func initialSize(){
        let scx:CGFloat = 768.0/360.0
        let scy:CGFloat = 1024.0/480.0
        
        
        var popUpViewCenX = CGFloat()
        var popUpViewCenY = CGFloat()
        
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad){
            font = 14*scy
            cellH = 40*scy
            fonttitle = 16*scy
            countdownLblFontsize = 30*scy
            popUpViewCenX = UIScreen.mainScreen().bounds.size.height/(1.7*scy)
            popUpViewCenY = UIScreen.mainScreen().bounds.size.width/(1.6*scx)
            streamViewRect = CGRectMake(0*scx, 0*scy, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width)
            popUpViewRect =  CGRectMake(0*scx, 0*scy, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width)
            popUpViewTopRect =  CGRectMake(0*scx, 0*scy, streamViewRect.size.width, 40*scy)
            
            popUpViewBotRect = CGRectMake(0*scx, streamViewRect.size.height - (70*scy), streamViewRect.size.width , 70*scy)
            
            popUpViewRightRect = CGRectMake(streamViewRect.size.width - (70*scx),40*scy,70*scx, streamViewRect.size.height - (110*scy))
            popUpViewLeftRect = CGRectMake(0*scx,40*scy,40*scx, streamViewRect.size.height - (110*scy))
            popUpViewCenRect = CGRectMake(streamViewRect.size.width/2 - popUpViewCenX, 45*scy , popUpViewCenX*2, streamViewRect.size.height - (120*scy))
            
            
            
            sliderRect = CGRectMake(popUpViewLeftRect.width/2-(100*scx),popUpViewLeftRect.height/2-(25*scy),200*scx,50*scy)
            changeCamBtnRect = CGRectMake(popUpViewRightRect.size.width - (65*scx) ,popUpViewRightRect.size.height - (65*scy) ,60*scx, 60*scy)
            flashBtnRect = CGRectMake(popUpViewRightRect.size.width - (65*scx) , popUpViewRightRect.size.height - (130*scy) ,60*scx, 60*scy)
            
            streamButtonRect = CGRectMake(popUpViewBotRect.size.width - (65*scx) ,5*scy ,60*scx, 60*scy)
            startStreamBtnRect = CGRectMake(popUpViewBotRect.size.width - (65*scx) ,5*scy,60*scx, 60*scy)
            
            topCenViewRect = CGRectMake(10*scx, 10*scy, popUpViewCenRect.size.width-(20*scx), 40*scy)
            titleIconImgRect = CGRectMake(10*scx,topCenViewRect.size.height/2-(10*scy),20*scx, 20*scy)
            
            titleLblRect = CGRectMake(40*scx,topCenViewRect.size.height/2-(15*scy),50*scx,30*scy)
            titleTxtRect = CGRectMake(90*scx,topCenViewRect.size.height/2-(15*scy),topCenViewRect.size.width - 90*scx,30*scy)
            selectCatLblRect = CGRectMake(10*scx,60*scy,topCenViewRect.size.width/2,30*scy)
            categoryTxtRect = CGRectMake(topCenViewRect.size.width/2 + (10*scx),60*scy,topCenViewRect.size.width/2,30*scy)
            selectCatBtnRect = CGRectMake(topCenViewRect.size.width - (20*scx),60*scy,30*scx,30*scy)
            qualityLblRect = CGRectMake(10*scx,90*scy,topCenViewRect.size.width/2,30*scy)
            qualityTxtRect = CGRectMake(topCenViewRect.size.width/2+(10*scx),90*scy,topCenViewRect.size.width/2,30*scy)
            selectQualityBtnRect =  CGRectMake(topCenViewRect.size.width - 20*scx,90*scy,30*scx,30*scy)
            locationPinImgRect = CGRectMake(10*scx,130*scy,30*scx,35*scy)
            locationLblRect = CGRectMake(50*scx,135*scy,topCenViewRect.size.width - (50*scx),30*scy)
            detailLiveLblRect = CGRectMake(0*scx,popUpViewCenRect.size.height-(30*scy),popUpViewCenRect.size.width-(popUpViewCenRect.size.width/3),30*scy)
            timeDetailRect = CGRectMake(popUpViewCenRect.size.width-(popUpViewCenRect.size.width/3),popUpViewCenRect.size.height-(30*scy),popUpViewCenRect.size.width-(popUpViewCenRect.size.width/3),30*scy)
            categoryPickerViewRect = CGRectMake(topCenViewRect.size.width/2+(10*scx),80*scy,topCenViewRect.size.width/2,100*scy)
            qualityPickerViewRect = CGRectMake(topCenViewRect.size.width/2 + (10*scx),120*scy,topCenViewRect.size.width/2,100*scy)
            shareBtnRect = CGRectMake(UIScreen.mainScreen().bounds.size.height/2-popUpViewCenX/2,0*scy,50*scx,50*scy)
            shareFBBtnRect = CGRectMake(UIScreen.mainScreen().bounds.size.height/2-popUpViewCenX/2,20*scy,80*scx,30*scy)
            
            popUpViewChatRect = CGRectMake(45*scx, 60*scy , streamViewRect.size.width/2 , streamViewRect.size.height - (150*scy));
            imgUserChatRect = CGRectMake(2*scx, 2*scy, 35*scx , 35*scy)
            lblUserNameRect = CGRectMake((imgUserChatRect.size.width + imgUserChatRect.origin.x) + (5*scx), 2*scy, 70*scx , 30*scy)
            lblTextChatRect = CGRectMake(lblUserNameRect.origin.x + lblUserNameRect.size.width + (2*scx) , 2*scy, popUpViewChatRect.size.width - (50*scx), 30*scy)
            
            
            // top rect
            closeBtnRect = CGRectMake(popUpViewTopRect.size.width - (35*scx) ,5*scy,30*scx, 30*scy)
            locateLblRect = CGRectMake(popUpViewTopRect.size.width - (100*scx) , popUpViewTopRect.size.height/2 - (15*scy) , 60*scx ,30*scy)
            locateImgRect = CGRectMake(popUpViewTopRect.size.width - (120*scx) , popUpViewTopRect.size.height/2 - (10*scy) , 20*scx , 20*scy)
            lovecountLblRect = CGRectMake(popUpViewTopRect.size.width - (160*scx) , popUpViewTopRect.size.height/2 - (15*scy) , 40*scx ,30*scy)
            loveiconImgRect = CGRectMake(popUpViewTopRect.size.width - (180*scx) , popUpViewTopRect.size.height/2 - (10*scy) , 20*scx , 20*scy)
            viewcountLblRect = CGRectMake(popUpViewTopRect.size.width - (220*scx) , popUpViewTopRect.size.height/2 - (15*scy) , 40*scx ,30*scy)
            viewiconImgRect = CGRectMake(popUpViewTopRect.size.width - (245*scx), popUpViewTopRect.size.height/2 - (10*scy), 20*scx , 20*scy)
            titletopLblRect = CGRectMake( 40*scx , popUpViewTopRect.size.height/2 - (15*scy) , popUpViewTopRect.size.width/2 - 40*scx , 30*scy)
            liveiconImgRect = CGRectMake(5*scx, popUpViewTopRect.size.height/2 - (15*scy) , 30*scx , 30*scy)
            
            // view bottom
            chatBtnRect = CGRectMake(50*scx , popUpViewBotRect.size.height/2 - (20*scy) , 40*scx , 40*scy)
            shareLiveBtnRect = CGRectMake(105*scx , popUpViewBotRect.size.height/2 - (20*scy) , 40*scx , 40*scy)
            shareListViewRect = CGRectMake(150*scx , popUpViewBotRect.size.height/2 - (30*scy) , popUpViewBotRect.size.width - 250*scx , 60*scy)
            facebookBtnRect = CGRectMake(10*scx , shareListViewRect.size.height/2 - (20*scy) , 40*scx ,40*scy )
            googleBtnRect = CGRectMake(55*scx,shareListViewRect.size.height/2 - (20*scy) ,40*scx,40*scy)
            tweeterBtnRect = CGRectMake(100*scx,shareListViewRect.size.height/2 - (20*scy) ,40*scx,40*scy)
            linekBtnRect = CGRectMake(145*scx,shareListViewRect.size.height/2 - (20*scy) ,40*scx,40*scy)
            copyLinkBtnRect = CGRectMake(190*scx,shareListViewRect.size.height/2 - (20*scy) ,40*scx,40*scy)
            alertViewRect = CGRectMake(popUpViewCenRect.origin.x, popUpViewCenRect.origin.y + popUpViewCenRect.size.height/4, popUpViewCenRect.size.width, popUpViewCenRect.size.height/2);
            alertTitleLblRect = CGRectMake(0*scx, 10*scy , alertViewRect.size.width, 30*scy);
            subAlertTitleLblRect = CGRectMake(0*scx, 40*scy , alertViewRect.size.width, 30*scy);
            okBtnAlertRect = CGRectMake(0*scx,alertViewRect.size.height - (40*scy) , alertViewRect.size.width/2, 40*scy);
            cancelBtnAlertRect = CGRectMake(alertViewRect.size.width/2,alertViewRect.size.height - (40*scy) , alertViewRect.size.width/2, 40*scy);
            titimeStreamLblRect = CGRectMake(streamButtonRect.origin.x - (60*scx), popUpViewBotRect.size.height/2 - (15*scy), 60*scx, 30*scy);
            countDownRect = CGRectMake(popUpViewRect.size.width/2 - (30*scx), popUpViewRect.size.height/2 - (30*scy), 60*scx, 60*scy);
        }
        else{
            font = 14
            cellH = 45
            fonttitle = 16
            countdownLblFontsize = 30
            popUpViewCenX = UIScreen.mainScreen().bounds.size.height/1.7
            popUpViewCenY = UIScreen.mainScreen().bounds.size.width/1.6
            streamViewRect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width)
            popUpViewRect =  CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width)
            popUpViewTopRect =  CGRectMake(0, 0, streamViewRect.size.width, 40)
            popUpViewBotRect = CGRectMake(0, streamViewRect.size.height - 70, streamViewRect.size.width , 70)
            
            popUpViewRightRect = CGRectMake(streamViewRect.size.width - 70,40,70, streamViewRect.size.height - 110)
            popUpViewLeftRect = CGRectMake(0,40,40, streamViewRect.size.height - 110)
            popUpViewCenRect = CGRectMake(streamViewRect.size.width/2-popUpViewCenX/2, 45 , popUpViewCenX, streamViewRect.size.height - 120)
            
            
            
            sliderRect = CGRectMake(popUpViewLeftRect.width/2-100,popUpViewLeftRect.height/2-25,200,50)
            changeCamBtnRect = CGRectMake(popUpViewRightRect.size.width - 65 ,popUpViewRightRect.size.height - 65 ,60, 60)
            flashBtnRect = CGRectMake(popUpViewRightRect.size.width - 65 , popUpViewRightRect.size.height - 130 ,60, 60)
            
            streamButtonRect = CGRectMake(popUpViewBotRect.size.width - 65 ,5 ,60, 60)
            startStreamBtnRect = CGRectMake(popUpViewBotRect.size.width - 65 ,5,60, 60)
            
            topCenViewRect = CGRectMake(10, 10, popUpViewCenRect.size.width-20, 40)
            titleIconImgRect = CGRectMake(10,topCenViewRect.size.height/2-10,20, 20)
            
            titleLblRect = CGRectMake(40,topCenViewRect.size.height/2-15,50,30)
            titleTxtRect = CGRectMake(90,topCenViewRect.size.height/2-15,topCenViewRect.size.width - 90,30)
            selectCatLblRect = CGRectMake(10,60,topCenViewRect.size.width/2,30)
            categoryTxtRect = CGRectMake(topCenViewRect.size.width/2+10,60,topCenViewRect.size.width/2,30)
            selectCatBtnRect = CGRectMake(topCenViewRect.size.width - 20,60,30,30)
            qualityLblRect = CGRectMake(10,90,topCenViewRect.size.width/2,30)
            qualityTxtRect = CGRectMake(topCenViewRect.size.width/2+10,90,topCenViewRect.size.width/2,30)
            selectQualityBtnRect =  CGRectMake(topCenViewRect.size.width - 20,90,30,30)
            locationPinImgRect = CGRectMake(10,130,30,35)
            locationLblRect = CGRectMake(50,135,topCenViewRect.size.width - 50,30)
            detailLiveLblRect = CGRectMake(0,popUpViewCenRect.size.height-30,popUpViewCenRect.size.width-(popUpViewCenRect.size.width/3),30)
            timeDetailRect = CGRectMake(popUpViewCenRect.size.width-(popUpViewCenRect.size.width/3),popUpViewCenRect.size.height-30,popUpViewCenRect.size.width-(popUpViewCenRect.size.width/3),30)
            categoryPickerViewRect = CGRectMake(topCenViewRect.size.width/2+10,80,topCenViewRect.size.width/2,100)
            qualityPickerViewRect = CGRectMake(topCenViewRect.size.width/2+10,120,topCenViewRect.size.width/2,100)
            shareBtnRect = CGRectMake(UIScreen.mainScreen().bounds.size.height/2-popUpViewCenX/2,0,50,50)
            shareFBBtnRect = CGRectMake(UIScreen.mainScreen().bounds.size.height/2-popUpViewCenX/2,20,80,30)
            
            popUpViewChatRect = CGRectMake(45, 60 , streamViewRect.size.width/2 , streamViewRect.size.height - 150);
            imgUserChatRect = CGRectMake(2, 2, 35 , 35)
            lblUserNameRect = CGRectMake((imgUserChatRect.size.width + imgUserChatRect.origin.x)+10, 2, 70 , 30)
            lblTextChatRect = CGRectMake((imgUserChatRect.size.width + imgUserChatRect.origin.x)+10 , 2, popUpViewChatRect.size.width - 50, 30)
            
            
            
            // top rect
            closeBtnRect = CGRectMake(popUpViewTopRect.size.width - 35 ,5,30, 30)
            locateLblRect = CGRectMake(popUpViewTopRect.size.width - 100 , popUpViewTopRect.size.height/2 - 15 , 60 ,30)
            locateImgRect = CGRectMake(popUpViewTopRect.size.width - 120 , popUpViewTopRect.size.height/2 - 10 , 20 , 20)
            lovecountLblRect = CGRectMake(popUpViewTopRect.size.width - 160 , popUpViewTopRect.size.height/2 - 15 , 40 ,30)
            loveiconImgRect = CGRectMake(popUpViewTopRect.size.width - 180 , popUpViewTopRect.size.height/2 - 10 , 20 , 20)
            viewcountLblRect = CGRectMake(popUpViewTopRect.size.width - 220 , popUpViewTopRect.size.height/2 - 15 , 40 ,30)
            viewiconImgRect = CGRectMake(popUpViewTopRect.size.width - 245, popUpViewTopRect.size.height/2 - 10 , 20 , 20)
            titletopLblRect = CGRectMake( 40 , popUpViewTopRect.size.height/2 - 15 , popUpViewTopRect.size.width/2 - 40 , 30)
            liveiconImgRect = CGRectMake(5 , popUpViewTopRect.size.height/2 - 15 , 30 , 30)
            
            // view bottom
            chatBtnRect = CGRectMake(50 , popUpViewBotRect.size.height/2 - 20 , 40 , 40)
            shareLiveBtnRect = CGRectMake(105 , popUpViewBotRect.size.height/2 - 20 , 40 , 40)
            shareListViewRect = CGRectMake(150 , popUpViewBotRect.size.height/2 - 30 , popUpViewBotRect.size.width - 250 , 60)
            facebookBtnRect = CGRectMake(10 , shareListViewRect.size.height/2 - 20 , 40 ,40 )
            googleBtnRect = CGRectMake(55,shareListViewRect.size.height/2 - 20 ,40,40)
            tweeterBtnRect = CGRectMake(100,shareListViewRect.size.height/2 - 20 ,40,40)
            linekBtnRect = CGRectMake(145,shareListViewRect.size.height/2 - 20 ,40,40)
            copyLinkBtnRect = CGRectMake(190,shareListViewRect.size.height/2 - 20 ,40,40)
            
            alertViewRect = CGRectMake(popUpViewCenRect.origin.x, popUpViewCenRect.origin.y + popUpViewCenRect.size.height/4, popUpViewCenRect.size.width, popUpViewCenRect.size.height/2);
            alertTitleLblRect = CGRectMake(0, 10 , alertViewRect.size.width, 30);
            subAlertTitleLblRect = CGRectMake(0, 40 , alertViewRect.size.width, 30);
            okBtnAlertRect = CGRectMake(0,alertViewRect.size.height - 40 , alertViewRect.size.width/2, 40);
            cancelBtnAlertRect = CGRectMake(alertViewRect.size.width/2,alertViewRect.size.height - 40 , alertViewRect.size.width/2, 40);
            
            titimeStreamLblRect = CGRectMake(streamButtonRect.origin.x - 60, popUpViewBotRect.size.height/2 - 15, 60, 30);
            countDownRect = CGRectMake(popUpViewRect.size.width/2 - 30, popUpViewRect.size.height/2 - 30, 60, 60);

        }
        
        
    }
    func getQualityStream(qualityName:String) ->CGSize
    {
        switch qualityName
        {
        case "FULLHD":
            return CGSize(width: 1920, height: 1080)
        case "High" :
            return CGSize(width: 1280, height: 720)
        case "Medium" :
            return CGSize(width: 640, height: 480)
        case "Low" :
            return CGSize(width: 480, height: 360)
        default :
            return CGSize(width: 640, height: 480)
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let cell  = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        cell.alpha = 0.5
        
//        let view = UIView(frame:CGRectMake(imgUserChatRect.size.width + 10,2,cell.contentView.bounds.size.width - (imgUserChatRect.size.width + 10) ,cell.contentView.bounds.size.height - 4))
//        view.backgroundColor = UIColor.whiteColor()
//        view.layer.cornerRadius = 5
//        view.clipsToBounds = true
//        cell.contentView.addSubview(view)
        
        //        var cm = Commentator()
        let cm = comments.objectAtIndex(indexPath.row) as! Commentator
        
        
        imgUserChat = UIImageView(frame:imgUserChatRect)
        //        imgUserChat.image = UIImage(named: "image1.jpg")
        imgUserChat.image = UIImage(data: NSData(contentsOfURL: NSURL(string: cm.profile_picture)!)!)
        imgUserChat.layer.cornerRadius = 5
        imgUserChat.clipsToBounds = true
        cell.contentView.addSubview(imgUserChat)
        
        
        let scy :CGFloat = (1024.0/480.0)
        let scx :CGFloat = (768.0/360.0);
        if (UI_USER_INTERFACE_IDIOM() == .Pad) {
        
            chatplaceView = UIView(frame:CGRectMake(55*scx, 2*scy ,tableView.bounds.size.width - (54*scx), cellH - (4*scy )))
            lblTextChat = UILabel(frame : CGRectMake(55*scx, 4*scy , chatplaceView.bounds.size.width - (10*scx) , 20*scy ))
            lblUserName = UILabel(frame : CGRectMake(55*scx ,lblTextChat.bounds.origin.y + lblTextChat.bounds.size.height + (2*scy) , chatplaceView.bounds.size.width - (10*scx), 20*scy ))
            objChatLbl = UILabel(frame: CGRectMake(imgUserChatRect.size.width + (10*scx), 2*scy , chatplaceView.bounds.size.width-10, 30*scy ));
            
        }
        else{
            chatplaceView = UIView(frame:CGRectMake(55, 2 ,tableView.bounds.size.width - (54), cellH - (4)))
            lblTextChat = UILabel(frame : CGRectMake(55, 4 , chatplaceView.bounds.size.width - (10) , 20 ))
            lblUserName = UILabel(frame : CGRectMake(55 ,lblTextChat.bounds.origin.y + lblTextChat.bounds.size.height + (2) , chatplaceView.bounds.size.width - (10), 20))
            objChatLbl = UILabel(frame: CGRectMake(imgUserChatRect.size.width + 10, 2, chatplaceView.bounds.size.width-10 , 30));
        }

        
        
        let firstandlastname = "\(cm.first_name) \(cm.last_name) : "
        
        
        print("LAST NAME ::: \(cm.last_name) ")
        // lblUserName = UILabel(frame :lblUserNameRect)
        //        lblUserName.text = "User test"
//        lblUserName.text = firstandlastname as String
//        lblUserName.font = UIFont(name:  "Helvetica", size: font)
//        lblUserName.textAlignment = NSTextAlignment.Justified
//        lblUserName.sizeToFit()
        
        //cell.contentView.addSubview(lblUserName)
      //   lblTextChat.text =
       // lblTextChat.font = UIFont(name:  "Helvetica", size: font)
        
        let textChat = cm.comment_content as String
        
        chatplaceView.backgroundColor = UIColor.whiteColor()
        chatplaceView.layer.cornerRadius = 5;
        chatplaceView.clipsToBounds = true;
     //   cell.contentView.addSubview(chatplaceView)

        objChatLbl.text = firstandlastname + textChat
        objChatLbl.backgroundColor = UIColor.whiteColor()
        objChatLbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
        objChatLbl.numberOfLines = 0;
        objChatLbl.textAlignment = NSTextAlignment.Justified;
        objChatLbl.sizeToFit()
        objChatLbl.layer.cornerRadius = 5
        objChatLbl.clipsToBounds = true
        cell.contentView.addSubview(objChatLbl)
        
        
        
//        lblTextChat.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        lblTextChat.numberOfLines = 0 ;
//        lblTextChat.textAlignment = NSTextAlignment.Justified
//        lblTextChat.sizeToFit()
//        cell.contentView.addSubview(lblTextChat)
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (objChatLbl.bounds.size.height <= cellH) {
            return cellH ;
        }
        else{
            let scy:CGFloat = (1024.0/480.0);
            let scx:CGFloat = (768.0/360.0);
            if (UI_USER_INTERFACE_IDIOM() == .Pad) {
                
                chatplaceView.frame = CGRectMake(52*scx, 2*scy, tableView.bounds.size.width - (54*scx) ,objChatLbl.bounds.size.height + (10*scy))
            //chatplaceView.backgroundColor = UIColor.clearColor()
             //   lblUserName.frame = CGRectMake(55*scx,lblTextChat.bounds.origin.y + lblTextChat.bounds.size.height + (2*scy) , chatplaceView.bounds.size.width - (10*scx), 20*scx)
            
                return  objChatLbl.bounds.size.height + (10*scy);
            }
            else{
                chatplaceView.frame = CGRectMake(52, 2 , tableView.bounds.size.width - (54) ,objChatLbl.bounds.size.height + 10)
                
              //  lblUserName.frame = CGRectMake(55,lblTextChat.bounds.origin.y + lblTextChat.bounds.size.height + (2) , chatplaceView.bounds.size.width - (10), 20)
                
                return chatplaceView.bounds.size.height;
            }

        }
        
        tableView.reloadData()
    }
    func initialCatPickerView(sender:UIButton){
        
        print("Show PickerView")
        
        categoryPickerView!.hidden = false
        
    }
    func initialQualityPickerView(sender:UIButton){
        
        print("Show PickerView")
        
        qualityPickerView!.hidden = false
        
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView .isEqual(categoryPickerView)){
            //            return catArray.count;
            return appDelegate.categoryData.count;
        }
        else
        {
            return qualityArray.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView .isEqual(categoryPickerView)){
            
            
            //            return catArray[row]
            //            print("category_name_en \(appDelegate.categoryData[row]["category_name_en"])")
            return (appDelegate.categoryData[row]["category_name_en"] as! String);
        }
        else{
            return qualityArray[row]
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView .isEqual(categoryPickerView)){
            //            categoryTxt!.text = catArray[row]
            categoryTxt!.text = (appDelegate.categoryData[row]["category_name_en"] as! String)
            catID = Int(appDelegate.categoryData[row]["id"] as! String)!
            print("catID = \(catID)")
            pickerView.hidden = true
        }
        else{
            qualityTxt!.text = qualityArray[row]
            pickerView.hidden = true
        }
        
    }
    func dismissKeyboard() {
        print("dismissKeyboard");
        qualityPickerView!.hidden = true
        categoryPickerView!.hidden = true
        self.view.endEditing(true)
        
    }
    func startChat( sender : UIButton) {
        
//        popUpViewChat!.hidden = false
        
        print("IS CHAT ::: \(appDelegate.isChat)")
        
        if (!appDelegate.isChat) {
            
            appDelegate.isChat = true
            popUpViewChat!.hidden = false
        }
        else{
            appDelegate.isChat = false
            popUpViewChat!.hidden = true
            
        }
        
        popUpViewChat!.reloadInputViews()
        //appDelegate.isChat = false
        
        //   print("IS CHAT ::: \(appDelegate.isChat)")
        
    }
    func startShare(sender : UIButton) {
        
        print("IS SHARE ::: \(appDelegate.isShare)")
        if (!appDelegate.isShare) {
            
            appDelegate.isShare = true
            shareLiveBtn?.setImage(UIImage(named: "close.png"), forState: UIControlState.Normal)
            shareListView.hidden = false
            // popUpViewChat!.hidden = true
            
        }
        else{
            appDelegate.isShare = false
            shareLiveBtn?.setImage(UIImage(named: "share_2.png"), forState: UIControlState.Normal)
            shareListView.hidden = true
            //  popUpViewChat!.hidden = false
        }
        
        // popUpViewChat?.reloadInputViews()
    }
    func customIOS7AlertViewButtonTouchUpInside(alertView: CustomIOS7AlertView, buttonIndex: Int) {
        //print("DELEGATE: Button '\(buttons[buttonIndex])' touched")
        //alertView.close()
    }
    
    
    
    func createPopupView() -> UIView {
        
        popupView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width - 50, UIScreen.mainScreen().bounds.size.height - 50)
        
        popupView.backgroundColor = UIColor.blackColor()
        //   popupView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        
        //        popup=NSBundle.mainBundle().loadNibNamed("popupStreaming", owner: self, options: nil)[0] as! popupStream
        //        popup.frame = popupView.bounds
        //        popup.TitleTxt.delegate = self
        //        popup.TitleTxt.text = "no title"
        //        popup.closeBtn.addTarget(self, action: "closepopup:", forControlEvents: .TouchUpInside)
        //
        //        popup.changCamBtn.addTarget(self, action: "changeCameraDevice:", forControlEvents: .TouchUpInside)
        //        popup.startBtn.addTarget(self, action: "startstream:", forControlEvents: .TouchUpInside)
        //        popupView.addSubview(popup)
        
        // containerView.addSubview(subView1)
        return popupView
    }
    func changeCameraDevice(sender: UIButton) {
        
        
        switch (session.cameraState) {
            
            
        case VCCameraState.Front:
            session.cameraState = VCCameraState.Back;
            //            self.previewView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            break;
            
        case VCCameraState.Back:
            session.cameraState = VCCameraState.Front;
            //            self.previewView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            break;
        default:
            break;
        }
    }
    
    func closepopup(sender:UIButton){
        //        alertView.close()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
    deinit {
        connectBtn = nil
        //        previewView = nil
        session.delegate = nil;
    }
    func connectionStatusChanged(sessionState: VCSessionState) {
        print("session state \(session.rtmpSessionState.hashValue)")
        switch session.rtmpSessionState {
            
        case .Starting:
            //                    self.textButton.text = "Starting"
            startStreamBtn!.setTitle("Starting", forState: UIControlState.Normal)
            //connectBtn.setTitle("Connecting", forState: .Normal)
            if(self.timerValue != 0 && self.session.rtmpSessionState == .Started)
            {
                print("countDown")
                self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LiveStreamVC.countdown(_:)), userInfo: nil, repeats: true)
            }else if(self.timerValue == 0 && self.session.rtmpSessionState == .Started)
            {
                print("countUp")
                self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LiveStreamVC.countup(_:)), userInfo: nil, repeats: true)
                self.countdownLbl.hidden = true
            }
            
            break
        case .Started:
            //                    self.textButton.text = "STOP"
            startStreamBtn!.setTitle("STOP", forState: UIControlState.Normal)
            if(self.timerValue != 0)
            {
                print("countDown")
                self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LiveStreamVC.countdown(_:)), userInfo: nil, repeats: true)
            }else
            {
                print("countUp")
                self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LiveStreamVC.countup(_:)), userInfo: nil, repeats: true)
                self.countdownLbl.hidden = true
            }
//            startStreamBtn!.addTarget(self, action: #selector(LiveStreamVC.stopStream(_:)), forControlEvents: .TouchUpInside)
            break
        default:
            //                    self.textButton.text = "STOP"
            //            startStreamBtn!.setTitle("STOP!", forState: UIControlState.Normal)
            //            startStreamBtn!.addTarget(self, action: Selector("stopStream"), forControlEvents: .TouchUpInside)
            break
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        //hide Status bar
        return true;
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        // Remove observer of self.
        socket?.disconnect()
        print("disconnect socket")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        appDelegate.isLiveVC = true
        appDelegate.isChat = true
        appDelegate.isChat = true
        //        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        //        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        titleTxt!.text = "\(appDelegate.first_name) \(appDelegate.last_name)_\(appDelegate.date)"
        self.titletopLbl.text = "\(appDelegate.first_name) \(appDelegate.last_name)_\(appDelegate.date)"
        //        UIApplication.sharedApplication().statusBarOrientation = .LandscapeRight
        //        self.setNeedsStatusBarAppearanceUpdate()
        //        UIApplication.sharedApplication().setStatusBarOrientation(.LandscapeRight, animated: false)
        //
    }
    override func viewDidAppear(animated: Bool) {
        
        print("End viewwillDisappear")
        appDelegate.isLiveVC = false
        appDelegate.isChat = false
        
        //        self.popUpViewBot?.hidden = true
        //        let value = UIInterfaceOrientation.LandscapeRight.rawValue
        //        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        //        UIApplication.sharedApplication().setStatusBarOrientation(.LandscapeRight, animated: false)
    }
    override func viewDidDisappear(animated: Bool) {
       
        
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    //    func dismissPickerView() {
    //
    //        qualityPickerView!.hidden = true
    //        categoryPickerView!.hidden = true
    //
    //    }
    //    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    //        print("supportedInterfaceOrientations")
    //        return UIInterfaceOrientationMask.LandscapeRight
    //    }
    
    
    
    func toggleFlash(sender:UIButton) {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.On) {
                    device.torchMode = AVCaptureTorchMode.Off
                    flashBtn!.setImage(UIImage(named: "ic_flash2.png"), forState: .Normal)
                } else {
                    do {
                        try device.setTorchModeOnWithLevel(1.0)
                        flashBtn!.setImage(UIImage(named: "ic_flash.png"), forState: .Normal)
                    } catch {
                        print(error)
                    }
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation
    {
        return UIInterfaceOrientation.LandscapeRight
    }
    //    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    //        return [UIInterfaceOrientationMask.Portrait, UIInterfaceOrientationMask.Landscape, UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight, UIInterfaceOrientationMask.PortraitUpsideDown]
    //    }
    func timePlus(){
        //setting the delay time 60secs.
        let delay = 60 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            //call the method which have the steps after delay.
            self.stepsAfterDelay()

        }
         print("DELAY\(delay)")
    }
    func stepsAfterDelay(){
        //your code after delay takes place here...
    }
//    func updatetime(){
//        if(timecount > 0)
//        {
//            timeStreamLbl.text = String(timecount--)
//        }
//    }
    func update() {
        
        if(count > 0)
        {
            
            countdownLbl.text = String(count--)
            
            print("countdown :::: \(countdownLbl.text)")
            //            countDownLabel.text = String(count++)
        }
        
    }
    
    func shareMyLive(sender: AnyObject) {
        //        var tapRecognizer: UITapGestureRecognizer = (sender as! UITapGestureRecognizer)
        
        NSLog("Tag %ld", sender.tag)
        
        
        content.contentURL = NSURL(string: "http://www.codingexplorer.com")
        content.contentTitle = "<INSERT STRING HERE>"
        content.contentDescription = "<INSERT STRING HERE>"
//        content.imageURL = NSURL(string: "<INSERT STRING HERE>")
        
        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 100) * 0.5, 50, 100, 25)
        self.view.addSubview(button)
        
        
        
//        let firstActivityItem = "Text you want"
//        let secondActivityItem : NSURL = NSURL(string: "http//:www.google.com")!
//        // If you want to put an image
//        let image : UIImage = UIImage(named: "ic_flash2.png")!
//        
//        let activityViewController : UIActivityViewController = UIActivityViewController(
//            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
//        
//        
//        //        activityViewController.rotatingHeaderView()
//        // This lines is for the popover you need to show in iPad
//        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
//        
//        // This line remove the arrow of the popover to show in iPad
//        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
//        
//        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
//        
//        // Anything you want to exclude
//        activityViewController.excludedActivityTypes = [
//            UIActivityTypePostToWeibo,
//            UIActivityTypePrint,
//            UIActivityTypeAssignToContact,
//            UIActivityTypeSaveToCameraRoll,
//            UIActivityTypeAddToReadingList,
//            UIActivityTypePostToFlickr,
//            UIActivityTypePostToVimeo,
//            UIActivityTypePostToTencentWeibo
//        ]
//        
//        self.presentViewController(activityViewController, animated: true, completion: nil)
        
        
        
    }
    
    func valueChanged(sender: UISlider) {
        session.videoZoomFactor = 1.0+(slider!.value)/4
        print("zoomFac : \(1.0+(slider!.value)/4)")
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.LandscapeRight
        
    }
    
    func setSocketLive(roomID:Int) {
        print("room ID \(roomID)")
        socket = SocketIOClient(socketURL: NSURL(string: SocketURL)!, options: [.Log(true), .ForcePolling(true)])
        socket!.joinNamespace("/websocket")
        socket!.on("ack-connected") {data, ack in
            self.socket!.emit("join", "streamlive/\(roomID)")
            print("socket connected")
            print("socket Data \(data)")
            
        }
        
        socket!.on("lovescount:update") {data, ack in
            print("lovescount:update :  \(data)")
            print("lovescount:update ::: \(data[0]["data"]!!["loves_count"] as! String)")
            self.lovecountLbl.text = data[0]["data"]!!["loves_count"] as? String
        }
        socket!.on("watchedcount:update") { data, ack in
            print("watchedcount:update ::: \(data[0]["data"]!!["watchedCount"] as! String)")
            self.viewcountLbl.text = data[0]["data"]!!["watchedCount"] as? String
        }
        socket!.on("comment:new") { data, ack in
            print("comment:new ::: \(data[0]["data"]!!["comment_content"] as! String)")
            
            let comment = Commentator()
            comment.comment_content = data[0]["data"]!!["comment_content"] as? String
            comment.first_name = data[0]["data"]!!["commentator"]!!["first_name"] as? String
            comment.last_name = data[0]["data"]!!["commentator"]!!["last_name"] as? String
            comment.profile_picture = data[0]["data"]!!["commentator"]!!["profile_picture"] as! String
            self.comments.addObject(comment)
            self.tableView?.reloadData()
            //            self.lblTextChat.text = data[0]["data"]!!["comment_content"] as? String
            //            self.lblUserName.text = data[0]["data"]!!["commentator"]!!["first_name"] as? String
            //            self.imgUserChat.image = UIImage(data: NSData(contentsOfURL: NSURL(string: data[0]["data"]!!["commentator"]!!["profile_picture"] as! String)!)!)
        }

        
        socket!.connect()
    }
    func initSocket()
    {
        print("init Socket")
        let url = NSURL(fileURLWithPath: "http://192.168.9.117:3008")
        
        let socket = SocketIOClient(socketURL: url)
        socket.joinNamespace("/websocket")
        socket.on("ack-connected") {data, ack in
            /// Join room.
            socket.emit("join", "batman")
            
            print("Alldata : \(data)")
            /// Leave room.
            /// socket.emit("leave", "user/anonymous")
        }
        

        
        socket.on("message:new") {data, ack in
            
            print("message : \(data)")
            //            if let cur = data[0] as? Double {
            //                socket.emitWithAck("canUpdate", cur)(timeoutAfter: 0) {data in
            //                    socket.emit("update", ["amount": cur + 2.50])
            //                }
            //
            //                ack.with("Got your currentAmount", "dude")
            //            }
        }
        socket.connect()
    }
    func getStreamTime() -> NSInteger {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if ((defaults.stringForKey("isActivate")) != nil) {
            return 0
        }else
        {
            return 300
        }
    }
    
    
    func countdown(dt: NSTimer) {
        self.timerValue -= 1
        if self.timerValue < 0 {
            print("time invalidate")
            self.countDownTimer.invalidate()
            if(session.rtmpSessionState == .Started)
            {
                session.endRtmpSession()
            }
            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        }else if(self.timerValue <= 5){
            countdownLbl.text = String(self.timerValue)
            countdownLbl.textAlignment = .Center
          //  countdownLbl.contentMode = .Normal
            countdownLbl.backgroundColor = UIColor.clearColor()
            countdownLbl.layer.borderWidth = 2
            countdownLbl.layer.borderColor = UIColor.whiteColor().CGColor
            countdownLbl.layer.cornerRadius = countdownLbl.frame.size.width/2
            timeStreamLbl.text = String(self.timeFormatted(self.timerValue))
            
        }
        else {
//            self.setLabelText(self.timeFormatted(self.timerValue))
            print("time count : \(self.timeFormatted(self.timerValue))")
            timeStreamLbl.text = String(self.timeFormatted(self.timerValue))
        }
    }
    func countup(dt: NSTimer) {
        self.timerValue += 1
        print("time count up : \(self.timeFormatted(self.timerValue))")
        timeStreamLbl.text = String(self.timeFormatted(self.timerValue))
    }
    
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
//        let hours: Int = totalSeconds / 3600
//        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func  getLocationName() {
        // Add below code to get address for touch coordinates.
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: appDelegate.latitude, longitude: appDelegate.longitude)
        locationName = ""
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            print("All address : \(placeMark.addressDictionary)")
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                print("Name : \(locationName)")
            }
            
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                print("Thoroughfare : \(street)")
            }
            // State
            if let state = placeMark.addressDictionary!["State"] as? NSString {
                print("State : \(state)")
                self.locationName = state
            }
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                print("City : \(city)")
                self.locationName = "\(self.locationName!) \(city)"
                self.locateLbl.text = city as String
                self.locationLbl!.text = city as String
                self.titleTxt?.text = (self.locationName as! String)
                print("Location Name : \(self.locationName)")
            }

            
            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                print("ZIP : \(zip)")
            }
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                print("Country : \(country)")
            }

            
            
        })
        
    }
}

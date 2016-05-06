//
//  popupStream.swift
//  SeeItLiveThailand
//
//  Created by Touch on 1/14/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit


class popupStream: UIView {
    var SCALING_Y = CGFloat()
    var SCALING_X = CGFloat()
    @IBOutlet var lbltitle: UILabel!
    @IBOutlet var icontitle: UIImageView!
    @IBOutlet var iconlocation: UIImageView!
    @IBOutlet var lbllocation: UILabel!
    @IBOutlet var lblshowlocation: UILabel!
    
    @IBOutlet weak var TitleTxt: UITextField!
    @IBOutlet weak var changCamBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
     var textButton = UILabel()
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation. */
    override func drawRect(rect: CGRect) {
        // Drawing code
        textButton.frame = CGRectMake(0 ,startBtn.frame.size.height/2-10 ,startBtn.frame.size.width, 30)
           // startBtn.bounds
//        textButton.text = "LIVE"
        textButton.textAlignment = NSTextAlignment.Center
        textButton.font = UIFont.systemFontOfSize(20)
        textButton.textColor = UIColor.whiteColor()
        
        startBtn.setTitle("LIVE", forState: UIControlState.Normal)
        startBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        startBtn.titleLabel!.textAlignment = NSTextAlignment.Center
        startBtn.frame = CGRectMake(self.frame.size.width - 120 ,self.frame.size.height - 120 ,90, 90)
//        startBtn.addSubview(textButton)
   
        
        
    if (UI_USER_INTERFACE_IDIOM() == .Pad) {
      
        SCALING_Y = (1024.0/480.0)
        SCALING_X =  (768.0/360.0)
        
    lbltitle.font = UIFont.systemFontOfSize(30)
    lbllocation.font = UIFont.systemFontOfSize(30)
    lblshowlocation.font = UIFont.systemFontOfSize(30)
    TitleTxt.font = UIFont.systemFontOfSize(30)

        }
        

    }

}

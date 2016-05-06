//
//  ChatTableViewCell.swift
//  SeeItLiveThailand
//
//  Created by Touch Developer on 4/6/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet var imgUserChat : UIImageView!
    @IBOutlet var lblUserName : UILabel!
    @IBOutlet var lblTextChat : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

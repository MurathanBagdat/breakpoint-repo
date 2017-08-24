//
//  FeedCell.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 25.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var senderProfileImage: UIImageView!
    @IBOutlet weak var senderEmailAdressLabel: UILabel!
    @IBOutlet weak var senderMessageContentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    func configureCell(image : UIImage, email : String, time : String, content : String){
        self.senderProfileImage.image = image
        self.senderEmailAdressLabel.text = email
        self.timeLabel.text = time
        self.senderMessageContentLabel.text = content
    }
}

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
    
    
    func configureCell(image : UIImage, message : Message , email : String){
        
        self.senderEmailAdressLabel.text = email
        self.senderProfileImage.image = image
        self.timeLabel.text = message.timestamp
        self.senderMessageContentLabel.text = message.content
    }
}

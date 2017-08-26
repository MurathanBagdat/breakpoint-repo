//
//  GroupFeedCell.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 26.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var timsestampLabel: UILabel!
    @IBOutlet weak var userTextLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var usersProfileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell( profileImage : UIImage, message : Message , email : String){
        
        self.userTextLabel.text = message.content
        self.userEmailLabel.text = email
        self.usersProfileImage.image = profileImage
        self.timsestampLabel.text = message.timestamp
    }
    
}

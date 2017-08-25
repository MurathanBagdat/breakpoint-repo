//
//  UserCell.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 25.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {


    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
    
    
    func configureCelle(image : UIImage, email: String , isSelected : Bool ){
        self.userProfileImage.image = image
        self.userEmailLabel.text = email
        if isSelected{
            self.checkmarkImage.isHidden = false
        }else{
            self.checkmarkImage.isHidden = true
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

//
//  GroupsCell.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 26.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class GroupsCell: UITableViewCell {

    @IBOutlet weak var GroupName: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var numberOfMembersLabel: UILabel!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.backgroundColor = UIColor.clear
        }
    }
    
    func configurCell(group : Group) {
        self.GroupName.text = group.title
        self.groupDescription.text = group.description
        self.numberOfMembersLabel.text = "\(group.members.count) Members"
    }
}

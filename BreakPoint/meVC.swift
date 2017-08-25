//
//  meVC.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

class meVC: UIViewController {

    //Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userEmailLabel.text = Auth.auth().currentUser?.email
    }

    
    //Actions###
    @IBAction func signoutButtonPrsd(_ sender: UIButton) {
        try? Auth.auth().signOut()
        performSegue(withIdentifier:SIGNOUT, sender: nil)
    }
 
}

//
//  SecondViewController.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {

    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func toNewGroupVCButtonPrsd(_ sender: UIButton) {
        performSegue(withIdentifier: TO_NEW_GROUPVC, sender: nil)
    }
}


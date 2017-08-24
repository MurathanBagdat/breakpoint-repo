//
//  FirstViewController.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //Actions##
    @IBAction func createPostButtonPrsd(_ sender: UIButton) {
        performSegue(withIdentifier: TO_POSTVC, sender: nil)
    }
}


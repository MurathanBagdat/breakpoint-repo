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
    
    //Variables
    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.delegate = self
        tableView.dataSource = self
        DataService.instance.getFeedMessages { (returnedMessages) in
            self.messages = returnedMessages.reversed()
            self.tableView.reloadData()
        }
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        messages.removeAll()
        DataService.instance.getFeedMessages { (returnedMessages) in
            self.messages = returnedMessages.reversed()
            self.tableView.reloadData()
        }
    }
    
    //Actions##
    @IBAction func createPostButtonPrsd(_ sender: UIButton) {
        performSegue(withIdentifier: TO_POSTVC, sender: nil)
    }
}


extension FeedVC : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCell else {return UITableViewCell()}
        
        let image = UIImage(named: "defaultProfileImage")
        let message = messages[indexPath.row]
        
        DataService.instance.getEmail(forUID: message.senderId) { (emailadress) in
            
            cell.configureCell(image: image!, message: message, email: emailadress)
        }
        return cell
    }
    
}

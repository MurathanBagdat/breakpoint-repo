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
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        messages.removeAll()
        DataService.instance.getFeedMessages { (messages) in
            for message in messages{
                self.messages.append(message)
            }
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
        let email = "murathanbagdat@hotmail.com"
        let messageContent = messages[indexPath.row].content
        let messageTime = messages[indexPath.row].timestamp
        
        cell.configureCell(image: image!, email: email, time: messageTime, content: messageContent)
        
        return cell
    }
    
}

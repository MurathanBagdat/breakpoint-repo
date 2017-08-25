//
//  NewGroupVC.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 25.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class NewGroupVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addYourFriendsLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleTextLabel: TextFieldWithInsets!
    @IBOutlet weak var descriptionTextLabel: TextFieldWithInsets!
    @IBOutlet weak var addYourFriendsTextField: TextFieldWithInsets!
    
    
    //Variables
    var emails = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Actions
    @IBAction func doneButtonPrsd(_ sender: Any) {
    }
    @IBAction func closeButtonPrsd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func editingChanged(_ sender: TextFieldWithInsets) {
        if addYourFriendsTextField.text != "" {
            DataService.instance.getEmail(forSearchQuery: addYourFriendsTextField.text!) { (emailArray) in
                self.emails = emailArray
                self.tableView.reloadData()
            }
        }else{
            emails.removeAll()
            tableView.reloadData()
        }
    }
  
   
}
extension NewGroupVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else { return UITableViewCell() }
        
        let image = UIImage(named: "defaultProfileImage")
        let email = emails[indexPath.row]
        
        
        cell.configureCelle(image: image!, email: email , isSelected: true)
        return cell
        
    }
    
    
}

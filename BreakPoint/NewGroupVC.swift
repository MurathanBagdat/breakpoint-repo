//
//  NewGroupVC.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 25.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

class NewGroupVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addYourFriendsLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleTextLabel: TextFieldWithInsets!
    @IBOutlet weak var descriptionTextLabel: TextFieldWithInsets!
    @IBOutlet weak var addYourFriendsTextField: TextFieldWithInsets!
    @IBOutlet weak var scroll: UIScrollView!
   

    
    
    //Variables
    var emails = [String]()
    var selectedEmails = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerForKeyboardNotifications()
        
        
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        doneButton.isHidden = true
    }
    
    //Actions
    @IBAction func doneButtonPrsd(_ sender: Any) {
        if titleTextLabel.text != "" && descriptionTextLabel.text != "" {
            DataService.instance.getUID(byEmail: selectedEmails) { (uids) in
                var uidArray = uids
                uidArray.append((Auth.auth().currentUser?.uid)!)
                DataService.instance.createGroup(title: self.titleTextLabel.text!, description: self.descriptionTextLabel.text!, uids: uidArray, completion: { (succes) in
                    if succes{
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }else{
            let alertController = UIAlertController(title: "Please give your group a title and description", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        
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
    
    
    //dismisses the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        if selectedEmails.contains(email) {
            cell.configureCelle(image: image!, email: email , isSelected: true)
        }else{
            cell.configureCelle(image: image!, email: email , isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        
        if !selectedEmails.contains(cell.userEmailLabel.text!){
            selectedEmails.append(cell.userEmailLabel.text!)
            addYourFriendsLabel.text = selectedEmails.joined(separator: ", ")
            doneButton.isHidden = false
            tableView.reloadData()
        }else{
            selectedEmails = selectedEmails.filter({ $0 != cell.userEmailLabel.text })
            if selectedEmails.count > 0 {
                addYourFriendsLabel.text = selectedEmails.joined(separator: ", ")
                doneButton.isHidden = false
            }else{
                addYourFriendsLabel.text = "add your friends to your group"
                doneButton.isHidden = true
            }
            tableView.reloadData()
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWasShown(_:)),
                                               name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillBeHidden(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
            let keyboardFrameValue =
            info[UIKeyboardFrameBeginUserInfoKey] as? NSValue
            else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
    
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0,
                                             keyboardSize.height, 0.0)
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
    
        }
    
    func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
    }
    
}

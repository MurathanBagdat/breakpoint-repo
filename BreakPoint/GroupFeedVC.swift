//
//  GroupFeedVC.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 26.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupMembersLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: TextFieldWithInsets!
    
    
    //Variables
    var group : Group?
    var messages = [Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //keyboardStuff#######
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //keyboardStuff#######
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let group = group{
            self.groupNameLabel.text = group.title
            DataService.instance.getEmail(forGroup: group, handler: { (returnedArray) in
                self.groupMembersLabel.text = returnedArray.joined(separator: ", ")
            })
            DataService.instance.REF_GROUPS.observe(.value, with: { (groupDataSnapshot) in
                DataService.instance.getMessagesForGroup(group: group, handler: { (returnedMessages) in
                    self.messages = returnedMessages
                    self.tableView.reloadData()
                    self.scrollDownTheTableView()
                })
            })
        }
        scrollDownTheTableView()
    }
    
    func initData(ForGroup group : Group){
        self.group = group
    }
    

    //Actions
    @IBAction func sendButtonPrsd(_ sender: Any) {
        if textField.text != "" {
            let date = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            let dateInString = formatter.string(from: date)

            DataService.instance.uploadPostToDB(withMessage: textField.text!, andUID: (Auth.auth().currentUser?.uid)!, andGroupKey: group?.key, timestamp: dateInString , PostCompletion: { (succes) in
                if succes{
                    self.textField.text = ""
                }
            })
        }
    }
    @IBAction func backButtonPrsd(_ sender: UIButton) {
        dismissDetail()
    }
    
    
    
    //KeyoardStuff
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func keyboardWillShowNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification:notification)
    }
    func keyboardWillHideNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification:notification)
    }
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        bottomConstraint.constant = (view.bounds).maxY - (convertedKeyboardEndFrame).minY
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
            self.view.layoutIfNeeded()
            self.scrollDownTheTableView()
        }, completion: nil)
    }
    
    func scrollDownTheTableView() {
        if messages.count > 0{
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
}

extension GroupFeedVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else {return UITableViewCell()}
        
        let image = UIImage(named: "defaultProfileImage")
        let message = messages[indexPath.row]
        DataService.instance.getEmail(forUID: message.senderId) { (returnedEmail) in
            cell.configureCell(profileImage: image!, message: message, email: returnedEmail)
        }
        return cell
    }
}












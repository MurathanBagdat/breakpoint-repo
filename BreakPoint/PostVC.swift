//
//  PostVC.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

class PostVC: UIViewController {

    //Outlets
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var buttonsBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var viewsBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        sendButton.isEnabled = false
        
        //keyboardStuff#######
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //keyboardStuff#######
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userEmailLabel.text = Auth.auth().currentUser?.email
    }
    
    
  //Actions###
    @IBAction func sendButtonPrsd(_ sender: UIButton) {
        textField.resignFirstResponder()
        guard let text = textField.text , textField.text != "", textField.text != "Say something.." else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        sendButton.isEnabled = false
        if Auth.auth().currentUser != nil {
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            let dateInString = formatter.string(from: date)
            
            DataService.instance.uploadPostToDB(withMessage: text, andUID: uid, andGroupKey: nil, timestamp: dateInString , PostCompletion: { (succes) in
                if succes{
                    self.sendButton.isEnabled = true
                    self.textField.text = ""
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.sendButton.isEnabled = true
                    self.textField.text = "Could not send the message please try again.."
                }
            })
        }
    }
    @IBAction func closeButtonPrsd(_ sender: UIButton) {
        textField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    
    //Handling keyboardAndView!#######
    
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
        
        viewsBottomConstraint.constant = (view.bounds).maxY - (convertedKeyboardEndFrame).minY
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension PostVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textField.text = ""
        sendButton.isEnabled = true
    }
}

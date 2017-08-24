//
//  SigninVC.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class LoginVC: UIViewController , UITextFieldDelegate{
    
    //Outlets
    @IBOutlet weak var emailField: TextFieldWithInsets!
    @IBOutlet weak var passwordField: TextFieldWithInsets!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
    }

    
    //Actions####
    @IBAction func signinButtonPrsd(_ sender: UIButton) {
        guard let email = emailField.text , emailField.text != nil else {return}
        guard let password = passwordField.text , passwordField.text != nil else {return}
        
        AuthService.intance.loginUser(withEmail: email, andPassword: password) { (succes, error) in
            if succes{
                print("first succes")
                self.dismiss(animated: true, completion: nil)
            }else{
                print(error?.localizedDescription ?? "")
            }
            
            AuthService.intance.createUser(withEmail: email, andPassword: password, UserCreationComplete: { (succes, error) in
                if succes{
                    AuthService.intance.loginUser(withEmail: email, andPassword: password, loginComplete: { (succes, error) in
                        if succes{
                            self.dismiss(animated: true, completion: nil)
                        }else{
                            print(error?.localizedDescription ?? "")
                        }
                    })
                }else{
                    print(error?.localizedDescription ?? "")
                }
            })
        }
    }
    
    
    @IBAction func closeButtonPrsd(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
 
}


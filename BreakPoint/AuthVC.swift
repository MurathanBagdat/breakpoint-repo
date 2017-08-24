//
//  LoginVC.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //Actions####
    @IBAction func loginWithFBButtonPrsd(_ sender: UIButton) {
    }
    @IBAction func loginWithGoogleBtnPrsd(_ sender: UIButton) {
    }
    @IBAction func loginWithEmailBtnPrsd(_ sender: UIButton) {
        performSegue(withIdentifier: TO_SIGNINVC, sender: nil)
    }
    //keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

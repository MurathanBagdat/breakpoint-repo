//
//  SigninVC.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController , UITextFieldDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    //Outlets
    @IBOutlet weak var emailField: TextFieldWithInsets!
    @IBOutlet weak var passwordField: TextFieldWithInsets!
    @IBOutlet weak var profileImage: CircleImage!
    

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
                self.performSegue(withIdentifier: TO_FEEVC, sender: nil)
            }else{
                print(error?.localizedDescription ?? "")
            }
            
            AuthService.intance.createUser(withEmail: email, andPassword: password, UserCreationComplete: { (succes, error) in
                if succes{
                    AuthService.intance.loginUser(withEmail: email, andPassword: password, loginComplete: { (succes, error) in
                        if succes{
                            
                            let imageName = NSUUID().uuidString
                            guard let data = UIImagePNGRepresentation(self.profileImage.image!) else {return}
                            
                            StorageService.instance.REF_IMAGE.child("\(imageName).png").putData(data, metadata: nil, completion: { (metadata, error) in
                                
                                if error != nil{
                                    print(error as Any)
                                    return
                                }
                                guard let metadata = metadata?.downloadURL() else {return}
                                
                                 let userData = ["email" : email, "profileImageURL" : metadata.absoluteString]
                                
                                DataService.instance.createDBUser(uid: (Auth.auth().currentUser?.uid)!, userData: userData)
                                
                            })
                            self.performSegue(withIdentifier: TO_FEEVC, sender: nil)
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
    
    //IMAGEPICKER
    @IBAction func pickAnImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            
            profileImage.image = editedImage
            
        }else if let selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            
            profileImage.image = selectedImage
            
        }else{
            profileImage.image = UIImage(named: "defaultProfileImage")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func closeButtonPrsd(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    //keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 
}


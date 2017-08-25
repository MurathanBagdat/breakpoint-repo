//
//  AuthService.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import Foundation
import Firebase



class AuthService {
    
    static let intance = AuthService()
    
    func createUser(withEmail email : String, andPassword password : String , UserCreationComplete : @escaping (_ status : Bool, _ error : Error?)->()){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
           
            guard let user = user  else {
                UserCreationComplete(false, error)
                return
            }
            
            let userData = ["provider" : user.providerID, "email" : user.email!]
            
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            
            UserCreationComplete(true, nil)
 
        }
    }
    
    func loginUser(withEmail email : String, andPassword password : String , loginComplete : @escaping (_ status : Bool, _ error : Error?)->()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
                loginComplete(false, error)
            }
            loginComplete(true, nil)
        }
    }
}

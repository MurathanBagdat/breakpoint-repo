//
//  DataServices.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import Foundation
import Firebase


let DB_BASE = Database.database().reference()


class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE : DatabaseReference{
        return _REF_BASE
    }
    
    var REF_USERS : DatabaseReference{
        return _REF_USERS
    }
    
    var REF_GROUPS : DatabaseReference{
        return _REF_GROUPS
    }
    
    var REF_FEED : DatabaseReference{
        return _REF_FEED
    }
    
    
    func createDBUser(uid : String, userData : Dictionary<String , Any>){
        
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPostToDB(withMessage message : String , andUID uid : String , andGroupKey groupKey : String?, timestamp: String, PostCompletion : @escaping (_ succes : Bool) -> () ){
        
        if groupKey != nil{
            //send to group ref!!
        }
        REF_FEED.childByAutoId().updateChildValues(["content" : message, "senderID" : uid, "date" : timestamp])
        PostCompletion(true)
    }
    
    func getFeedMessages(handler : @escaping (_ messages: [Message])->()){
        var messages = [Message]()
        REF_FEED.observeSingleEvent(of: .value, with: { (feedDataSnapshot) in
            guard let feedDataSnapshot = feedDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for message in feedDataSnapshot {
                
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderID = message.childSnapshot(forPath: "senderID").value as! String
                let timestamp = message.childSnapshot(forPath: "date").value as! String
                
                let message = Message(content: content, senderId: senderID, timestamp: timestamp)
                messages.append(message)
            }
            handler(messages)
        })
    }
    
    func getEmail(forUID uid : String , handler : @escaping (_ email : String)->()){
        REF_USERS.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            guard let userDataSnapshot = userDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userDataSnapshot{
                if user.key == uid{
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        })
    }
}

















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
        
        if groupKey != nil {
            REF_GROUPS.observeSingleEvent(of: .value, with: { (groupsDataSnapshot) in
                guard let groupsDataSnapshot = groupsDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
                
                for group in groupsDataSnapshot {
                    if group.key == groupKey {
                        self.REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content" : message, "senderID" : uid , "date" : timestamp])
                    }
                }
                PostCompletion(true)
            })
        }else{
        REF_FEED.childByAutoId().updateChildValues(["content" : message, "senderID" : uid, "date" : timestamp])
            PostCompletion(true)
        }
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
    
    func getMessagesForGroup(group : Group , handler : @escaping (_ messages : [Message])->()){
        var messages = [Message]()
        
        REF_GROUPS.child(group.key).child("messages").observeSingleEvent(of: .value, with: { (messagesDataSnapshot) in
            guard let messagesDataSnapshot =  messagesDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for message in messagesDataSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let timestamp = message.childSnapshot(forPath: "date").value as! String
                let senderID = message.childSnapshot(forPath: "senderID").value  as! String
                
                let message = Message(content: content, senderId: senderID, timestamp: timestamp)
                messages.append(message)
            }
            handler(messages)
        })
    }
    
    
    func getGroupData(handler : @escaping (_ groups : [Group])->()){
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value, with: { (groupDataSnapshot) in
            
            guard let groupDataSnapshot = groupDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for group in groupDataSnapshot{
                let membersUids = group.childSnapshot(forPath: "members").value as! [String]
                
                if membersUids.contains((Auth.auth().currentUser?.uid)!){
                    
                    let groupTitle = group.childSnapshot(forPath: "Title").value as! String
                    let groupDescription = group.childSnapshot(forPath: "Description").value as! String

                    let group = Group(title: groupTitle, description: groupDescription, members: membersUids, key: group.key)
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
        })
    }
    
    func getEmail(forUID uid : String , handler : @escaping (_ email : String)->()){
        REF_USERS.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            
            guard let userDataSnapshot = userDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userDataSnapshot{
                
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        })
    }
    
    func getEmail(forSearchQuery query : String , handler : @escaping (_ emails : [String])->()){
        var emailArray = [String]()
        REF_USERS.observe(.value, with: { (userDataSnapshot) in
            guard let userDataSnapshot = userDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userDataSnapshot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) && Auth.auth().currentUser?.email != email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        })
    }
    func getEmail(forGroup group : Group , handler : @escaping (_ emails : [String])->()){
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            guard let userDataSnapshot = userDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userDataSnapshot {
                if group.members.contains(user.key){
                    emailArray.append(user.childSnapshot(forPath: "email").value as! String)
                }
            }
            handler(emailArray)
        })
    }
    
    
    func getUID(byEmail emails : [String], handler : @escaping (_ uidArray : [String] )->() ) {
        var uidArray = [String]()
        
        REF_USERS.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            
            guard let userDataSnapshot = userDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userDataSnapshot{
                let returndEmail = user.childSnapshot(forPath: "email").value as! String
                if emails.contains(returndEmail){
                    uidArray.append(user.key)
                }
            }
            handler(uidArray)
        })
    }
    
    func createGroup(title : String , description : String , uids : [String] , completion : @escaping (_ succes :Bool) -> () ){
        REF_GROUPS.childByAutoId().updateChildValues(["Title" : title , "Description" : description, "members" : uids ])
        completion(true)
    }
}

















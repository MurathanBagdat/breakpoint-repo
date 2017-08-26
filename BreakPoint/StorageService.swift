//
//  StorageService.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 26.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

let STORAGE_BASE = Storage.storage().reference()

class StorageService{
    
    static let instance = StorageService()
    
    private var  _REF_BASE = STORAGE_BASE
    private var  _REF_IMAGE = STORAGE_BASE.child("profileImages")
    
    var REF_BASE : StorageReference{
        return _REF_BASE
    }
    var REF_IMAGE :StorageReference{
        return _REF_IMAGE
    }
    
    
    
}

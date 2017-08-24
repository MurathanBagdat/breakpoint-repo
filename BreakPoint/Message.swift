//
//  Message.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 25.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import Foundation


class Message {
    
    private var _content : String
    private var _senderId : String
    private var _timestamp : String
    
    
    var content : String {
        return _content
    }
    var senderId : String{
        return _senderId
    }
    var timestamp : String{
        return _timestamp
    }
    
    init(content: String, senderId :String , timestamp : String) {
        self._content = content
        self._senderId = senderId
        self._timestamp = timestamp
    }
}

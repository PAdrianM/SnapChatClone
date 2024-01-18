//
//  UserSinglenton.swift
//  SNPClone
//
//  Created by Andrea Hernandez on 1/17/24.
//

import Foundation

class UserSinglenton {
    
    static let sharedUserInfo = UserSinglenton()
    
    var email = ""
    var username = ""
    
    private init() {
        
    }
    
    
}

//
//  LoginModel.swift
//  SportActivity
//
//  Created by Nail Safin on 04.10.2020.
//

import Foundation
import RealmSwift

class LoginModel: Object {
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
    
    override class func primaryKey() -> String? {
        return "login"
    }
}

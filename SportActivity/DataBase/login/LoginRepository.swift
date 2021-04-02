//
//  LoginRepository.swift
//  SportActivity
//
//  Created by Nail Safin on 04.10.2020.
//

import Foundation
import RealmSwift

class LoginRepository {
    
    func saveUser(login: String, pass: String) {
        
        do {
            let realm = try Realm()

            let newUser = LoginModel()
            newUser.login = login
            newUser.password = pass
            try! realm.write {
                realm.add(newUser)
            }
            
        } catch {
            print(error)
        }
       
    }
    
    func checkUser(log: String) -> Bool {
       
            let realm = try! Realm()
        if realm.objects(LoginModel.self).filter("login CONTAINS[c] %@", log).first != nil {
            
                return true }
            else {
                return false
                
            }
            
            
            
   
    }
    
    func chekUserandPassword(log: String, pass: String) -> Bool {
        let realm = try! Realm()
    if let login = realm.objects(LoginModel.self).filter("login CONTAINS[c] %@", log).first  {
        if login.password == pass {
            return true
        } else {
            return false
        }
        
        
    }
        else {
            return false
        }
    }
    
}

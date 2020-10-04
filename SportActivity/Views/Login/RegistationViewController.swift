//
//  RegistationViewController.swift
//  SportActivity
//
//  Created by Nail Safin on 04.10.2020.
//

import UIKit

class RegistationViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var fieldLogin: UITextField!
    
    @IBOutlet weak var fieldPassword: UITextField!
    
    @IBOutlet weak var secondFieldPassword: UITextField!
    
    var database = LoginRepository()
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    
    //MARK: - Handlers
    
    
    @IBAction func registratuinButton(_ sender: Any) {
        if fieldLogin != nil  {
            if fieldPassword.text == secondFieldPassword.text {
                if database.checkUser(log: fieldLogin.text ?? "") {
                    showDoubleLoginError()
                } else {
                    database.saveUser(login: fieldLogin.text ?? "nothing", pass: fieldPassword.text ?? "noPassword")
                    performSegue(withIdentifier: "goToLogin", sender: self)
                    
                }
                
                
            } else {
                showPasswordError()
            }
        } else {
            showLoginError()
        }
    }
    
    func showLoginError() {
        let alter = UIAlertController(title: "Ошибка", message: "не верно введен логин", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
        
    }
    
    func showDoubleLoginError() {
        let alter = UIAlertController(title: "Ошибка", message: "такой логин уже существует", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
        
    }
    
    func showPasswordError() {
        let alter = UIAlertController(title: "Ошибка", message: "пароли не совпадают", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Extensions
    
    
    

    // MARK: - Navigation
}

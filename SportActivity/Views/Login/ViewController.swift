//
//  ViewController.swift
//  SportActivity
//
//  Created by Nail Safin on 28.09.2020.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var mapDatailButton: UIButton!
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var addLogin: UITextField!
    @IBOutlet weak var addPassword: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var database = LoginRepository()
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    //MARK: - Handlers
    
    @IBAction func goToRegistrationButton(_ sender: UIButton) {
        
    }
    
    @IBAction func goToMapButton(_ sender: UIButton) {
        
        if addLogin.text != nil {
        
        if database.chekUserandPassword(log: addLogin.text ?? "", pass: addPassword.text ?? "") {
            self.performSegue(withIdentifier: "goToMap", sender: self)
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
    func showPasswordError() {
        let alter = UIAlertController(title: "Ошибка", message: "пароли не совпадают", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
        
    }
    // MARK: - Extensions
    
    
    

    // MARK: - Navigation
    
    
}


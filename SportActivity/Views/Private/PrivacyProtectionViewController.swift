//
//  PrivacyProtectionViewController.swift
//  SportActivity
//
//  Created by Nail Safin on 04.10.2020.
//

import UIKit

class PrivacyProtectionViewController: UIViewController {
    
    let mainView: privateView = {
        return $0
    }(privateView())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
    }
    



}

//
//  privateView.swift
//  SportActivity
//
//  Created by Nail Safin on 04.10.2020.
//

import Foundation
import UIKit
import PinLayout

class privateView: UIView{
    
    let backgroundView: UIView = {
        $0.backgroundColor = .black
        return $0
    }(UIView())
    
    let alert: UILabel = {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.text = "TOP SECRET"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
        
        return $0
    }(UILabel())
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadLayout()
    }
    
    
    func loadLayout() {
        self.backgroundColor = .darkGray
        backgroundView.pin(to: self).all(pin.safeArea)
        alert.pin(to:backgroundView).size(CGSize(width: 180, height: 180)).vCenter().hCenter()
        
    }
}

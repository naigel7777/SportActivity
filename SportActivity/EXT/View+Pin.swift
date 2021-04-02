//
//  View+Pin.swift
//  SportActivity
//
//  Created by Nail Safin on 04.10.2020.
//

import UIKit
import PinLayout

extension UIView {
    public func pin(to addView: UIView) -> PinLayout<UIView> {
        if !addView.subviews.contains(self) {
            addView.addSubview(self)
        }
        return self.pin
    }
}

//
//  UITextfield+Extension.swift
//  MyApp
//
//  Created by Facundo Lucero on 14/12/2021.
//

import Foundation
import UIKit

extension UITextField {
    func errorAnimated(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.4 / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [10, -10]
        self.layer.add(animation, forKey: "shake")
    }
}

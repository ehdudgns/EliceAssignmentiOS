//
//  UIView+Border.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/21.
//

import Foundation
import UIKit

extension UIView {
    func setBoder(radius: CGFloat?, width: CGFloat, color: UIColor) {
        layer.cornerRadius = radius ?? 0
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func makeCircle() {
        layer.cornerRadius = width / 2
        layer.masksToBounds = true
    }
    
    var width: CGFloat {
        frame.width
    }
    
    var height: CGFloat {
        frame.height
    }
}

//
//  UIColor+.swift
//  ToDo
//
//  Created by Mert Demirtaş on 11.01.2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}


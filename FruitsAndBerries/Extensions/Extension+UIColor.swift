//
//  Extension+UIColor.swift
//  iOS-Test
//
//  Created by Anton Mazur on 05.01.2024.
//

import UIKit.UIColor

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
   }

   convenience init(rgb: String) {
       var rgbIntValue: UInt64 = 0
       Scanner(string: rgb).scanHexInt64(&rgbIntValue)
       
       self.init(
           red: Int((rgbIntValue >> 16)) & 0xFF,
           green: Int((rgbIntValue >> 8)) & 0xFF,
           blue: Int(rgbIntValue) & 0xFF
       )
   }
}

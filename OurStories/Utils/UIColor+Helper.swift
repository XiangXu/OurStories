//
//  UIColor.swift
//  OurStories
//
//  Created by Xiang Xu on 23/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//
import UIKit

extension UIColor
{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor
    {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
//    #F74252
    static let lightRed = rgb(red: 247, green: 66, blue: 82)
    
    static let tealColor = rgb(red: 48, green: 164, blue: 182)
    
    static let darkBlue = rgb(red: 9, green: 45, blue: 64)
    
    static let lightBlue = rgb(red: 218, green: 235, blue: 243)
    
    static func dynamic(light: UIColor, dark: UIColor) -> UIColor
    {
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }
    
    // Warm, soft palette for the memory album look.
    static let rose = dynamic(light: rgb(red: 217, green: 84, blue: 110), dark: rgb(red: 240, green: 124, blue: 146))
    
    static let appBackground = dynamic(light: rgb(red: 251, green: 243, blue: 238), dark: rgb(red: 28, green: 21, blue: 23))
    
    static let cardBackground = dynamic(light: rgb(red: 255, green: 253, blue: 250), dark: rgb(red: 44, green: 34, blue: 37))
    
    static let titleText = dynamic(light: rgb(red: 58, green: 42, blue: 46), dark: rgb(red: 245, green: 234, blue: 230))
    
    static let bodyText = dynamic(light: rgb(red: 110, green: 90, blue: 94), dark: rgb(red: 200, green: 184, blue: 182))
}

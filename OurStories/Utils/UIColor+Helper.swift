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
}

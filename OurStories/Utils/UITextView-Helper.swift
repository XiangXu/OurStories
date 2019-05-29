//
//  UITextView-Helper.swift
//  OurStories
//
//  Created by Xiang Xu on 23/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import UIKit

class TypeOnTextView: UITextView {
    
    fileprivate var typeTimer: Timer? = nil
    
    func resetTypeOn()
    {
        self.typeTimer?.invalidate()
        self.text = ""
        self.typeTimer = nil
    }
    
    func typeOn(string: String) {
        let characterArray = string.characterArray
        var characterIndex = 0
        if typeTimer == nil
        {
            typeTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { (timmer) in
                if characterArray[characterIndex] != "$" {
                    while characterArray[characterIndex] == " " {
                        self.text.append(" ")
                        characterIndex += 1
                        if characterIndex == characterArray.count {
                            self.typeTimer?.invalidate()
                            self.typeTimer = nil
                            return
                        }
                    }
                    self.text.append(characterArray[characterIndex])
                }
                characterIndex += 1
                if characterIndex == characterArray.count {
                    self.typeTimer?.invalidate()
                     self.typeTimer = nil
                }
            }
        }
    }
}

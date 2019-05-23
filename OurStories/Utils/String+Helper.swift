//
//  String+Helper.swift
//  OurStories
//
//  Created by Xiang Xu on 23/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import UIKit

extension String {
    var characterArray: [Character]{
        var characterArray = [Character]()
        for character in self {
            characterArray.append(character)
        }
        return characterArray
    }
}

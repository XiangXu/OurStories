//
//  Story.swift
//  OurStories
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import Foundation

struct Story
{
    let location: String
    let storyContent: String
    let imageName: String
    
    init(location: String, storyContent: String, imageName: String)
    {
        self.location = location
        self.storyContent = storyContent
        self.imageName = imageName
    }
}

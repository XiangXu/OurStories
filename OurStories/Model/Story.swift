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
    
    static func storyGenerate() ->[Story]
    {
        return [
            Story(location: "爱尔兰-梅努斯", storyContent: "还记得多少年前第一次遇到你，也试过把你画在纸上用着水彩笔", imageName: "1.png"),
            Story(location: "法国-巴黎", storyContent: "你那迷人的双眼 我至今无法忘记，想跟你在一起 哪怕花光所有积蓄", imageName: "2.png"),
            Story(location: "英国-伦敦", storyContent: "当我长大了 烦恼变得更多了 每当遇到挫折 你陪我度过每一刻", imageName: "3.png")
        ]
    }
}

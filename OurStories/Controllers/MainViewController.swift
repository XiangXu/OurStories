//
//  MainViewController.swift
//  OurStories
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import UIKit
import Koloda

class MainViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate
{
    private var kolodaView: KolodaView = {
        let kolodaView = KolodaView()
        return kolodaView
    }()
    
    let stories = [
        Story(location: "爱尔兰-梅努斯", storyContent: "还记得多少年前第一次遇到你，也试过把你画在纸上用着水彩笔", imageName: "1.png"),
        Story(location: "法国-巴黎", storyContent: "你那迷人的双眼 我至今无法忘记，想跟你在一起 哪怕花光所有积蓄", imageName: "2.png"),
        Story(location: "英国-伦敦", storyContent: "当我长大了 烦恼变得更多了 每当遇到挫折 你陪我度过每一刻 ", imageName: "3.png")
    ]
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "我们的故事"
        MusicHelper.sharedHelper.playBackgroundMusic()
        
        setupKoloadView()
        
    }
    
    private func setupKoloadView()
    {
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        view.addSubview(kolodaView)
        kolodaView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil,
                          paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                          width: 300, height:500)
        kolodaView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int
    {
        return stories.count;
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView
    {
        let cardView = CardView()
        cardView.story = stories[index]
       
        if index == 0{
            cardView.contentTextField.typeOn(string: stories[index].storyContent)
        }
        return cardView
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if index + 1 < stories.count{
            let cardView = koloda.viewForCard(at: index+1) as! CardView
            cardView.contentTextField.typeOn(string: stories[index].storyContent)
        }
    }
}

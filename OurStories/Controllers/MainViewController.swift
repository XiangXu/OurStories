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
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "我们的回忆"
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
        return 3;
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView
    {
        let story = Story(location: "爱尔兰", storyContent: "第一次遇到你", imageName: "1.png")
        let cardView = CardView()
        cardView.story = story
        
        return cardView
    }
}

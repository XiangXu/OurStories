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
    let stories = Story.storyGenerate()
    
    private var kolodaView: KolodaView = {
        let kolodaView = KolodaView()
        return kolodaView
    }()
    
    private lazy var previousImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "smile")
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hanldePreviousCard)))
        return imageView
    }()
    
    private lazy var nextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heart")
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hanldeNextCard)))
        return imageView
    }()
    
    private lazy var resetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vibe")
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleResetCard)))
        return imageView
    }()
    
    @objc func hanldePreviousCard()
    {
        previousImageView.alphaAnimation()
        kolodaView.revertAction()
    }
    
    @objc func hanldeNextCard()
    {
        nextImageView.alphaAnimation()
        kolodaView.swipe(.right)
    }
    
    @objc func handleResetCard()
    {
        resetImageView.alphaAnimation()
        kolodaView.resetCurrentCardIndex()
    }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "我们的故事"
//        MusicHelper.sharedHelper.playBackgroundMusic()
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
        
        
        let stackView = UIStackView(arrangedSubviews: [previousImageView, resetImageView, nextImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 45
        
        view.addSubview(stackView)
        
        stackView.anchor(top: kolodaView.bottomAnchor, left: nil, bottom: nil, right: nil,
                         paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                         width: 300, height: 70)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("Did run out of cards")
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if index + 1 < stories.count{
            let cardView = koloda.viewForCard(at: index+1) as! CardView
            cardView.contentTextField.typeOn(string: stories[index].storyContent)
        }
    }
}

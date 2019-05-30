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
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "smile")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = .white
        button.layer.cornerRadius = 35
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(hanldePreviousCard), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = .white
        button.layer.cornerRadius = 35
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(hanldeNextCard), for: .touchUpInside)
        return button
    }()
    
    let resettButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "vibe")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = .white
        button.layer.cornerRadius = 35
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleResetCard), for: .touchUpInside)
        return button
    }()
    
    @objc func hanldePreviousCard()
    {
        kolodaView.revertAction()
    }
    
    @objc func hanldeNextCard()
    {
        kolodaView.swipe(.right)
    }
    
    @objc func handleResetCard()
    {
        kolodaView.resetCurrentCardIndex()
    }
    
    @objc func handleSelectMap()
    {
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "我们的故事"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "earth")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSelectMap))
        
//        MusicHelper.sharedHelper.playBackgroundMusic()
        setupKoloadView()
        
    }
    
    private func setupKoloadView()
    {
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        view.addSubview(kolodaView)
        kolodaView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,
                          paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8,
                          width: 0, height:500)
        kolodaView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [previousButton, resettButton, nextButton])
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
    
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
        if index != 0{
            let cardView = koloda.viewForCard(at: index) as! CardView
            cardView.contentTextField.resetTypeOn()
            cardView.contentTextField.typeOn(string: stories[index].storyContent)
        }
    }
}

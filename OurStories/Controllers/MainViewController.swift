//
//  MainViewController.swift
//  OurStories
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, CardDeckViewDataSource, CardDeckViewDelegate
{
    let stories = Story.storyGenerate()
    
    private var kolodaView: CardDeckView = {
        let kolodaView = CardDeckView()
        return kolodaView
    }()
    
    lazy var previousButton = makeRoundButton(symbolName: "arrow.left", identifier: "previous", isPrimary: false, action: #selector(hanldePreviousCard))
    
    lazy var nextButton = makeRoundButton(symbolName: "heart.fill", identifier: "next", isPrimary: true, action: #selector(hanldeNextCard))
    
    lazy var resettButton = makeRoundButton(symbolName: "arrow.counterclockwise", identifier: "reset", isPrimary: false, action: #selector(handleResetCard))
    
    private func makeRoundButton(symbolName: String, identifier: String, isPrimary: Bool, action: Selector) -> UIButton
    {
        let size: CGFloat = isPrimary ? 72 : 56
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: symbolName,
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: isPrimary ? 26 : 20, weight: .semibold))
        configuration.baseBackgroundColor = isPrimary ? .rose : .cardBackground
        configuration.baseForegroundColor = isPrimary ? .white : .rose
        configuration.cornerStyle = .capsule
        
        let button = UIButton(configuration: configuration)
        button.layer.shadowColor = UIColor.rgb(red: 190, green: 60, blue: 90).cgColor
        button.layer.shadowOpacity = isPrimary ? 0.4 : 0.15
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.anchor(top: nil, left: nil, bottom: nil, right: nil,
                      paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                      width: size, height: size)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.accessibilityIdentifier = identifier
        return button
    }
    
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
    
    @objc func handleToggleMusic()
    {
        if MusicHelper.sharedHelper.isPlaying {
            MusicHelper.sharedHelper.pauseBackgroundMusic()
        } else {
            MusicHelper.sharedHelper.playBackgroundMusic()
        }
        updateMusicButton()
    }
    
    private func updateMusicButton()
    {
        self.navigationItem.leftBarButtonItem?.image = MusicHelper.sharedHelper.isPlaying
            ? UIImage(systemName: "music.note")
            : UIImage(systemName: "music.note.slash") ?? UIImage(systemName: "speaker.slash.fill")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .appBackground
        self.navigationItem.title = "我们的故事"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "globe.europe.africa.fill"), style: .plain, target: self, action: #selector(handleSelectMap))
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "map"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(handleToggleMusic))
        self.navigationItem.leftBarButtonItem?.accessibilityIdentifier = "music"
        self.navigationItem.leftBarButtonItem?.tintColor = .rose
        self.navigationItem.rightBarButtonItem?.tintColor = .rose
        
        MusicHelper.sharedHelper.playBackgroundMusic()
        updateMusicButton()
        setupKoloadView()
        
    }
    
    private func setupKoloadView()
    {
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        let stackView = UIStackView(arrangedSubviews: [previousButton, resettButton, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 32
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil,
                         paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0,
                         width: 0, height: 72)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // The bottom padding leaves room for the cards stacked behind the top one.
        view.addSubview(kolodaView)
        kolodaView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: stackView.topAnchor, right: view.rightAnchor,
                          paddingTop: 12, paddingLeft: 20, paddingBottom: 44, paddingRight: 20,
                          width: 0, height: 0)
        
        kolodaView.reloadData()
    }
    
    func numberOfCards(in cardDeck: CardDeckView) -> Int
    {
        return stories.count
    }
    
    func cardDeck(_ cardDeck: CardDeckView, viewForCardAt index: Int) -> UIView
    {
        let cardView = CardView()
        cardView.story = stories[index]
        cardView.pageText = "\(index + 1) / \(stories.count)"
        return cardView
    }
    
    func cardDeckDidRunOutOfCards(_ cardDeck: CardDeckView) {
        // Start over from the first story.
        cardDeck.resetCurrentCardIndex()
    }
    
    func cardDeck(_ cardDeck: CardDeckView, didShowCardAt index: Int) {
        guard let cardView = cardDeck.topCard as? CardView else { return }
        cardView.contentTextField.resetTypeOn()
        cardView.contentTextField.typeOn(string: stories[index].storyContent)
    }
}

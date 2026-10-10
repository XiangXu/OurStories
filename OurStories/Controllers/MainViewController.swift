//
//  MainViewController.swift
//  OurStories
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import UIKit
import MessageUI

class MainViewController: UIViewController, CardDeckViewDataSource, CardDeckViewDelegate, MFMailComposeViewControllerDelegate
{
    let stories = Story.storyGenerate()
    
    private var kolodaView: CardDeckView = {
        let kolodaView = CardDeckView()
        return kolodaView
    }()
    
    lazy var previousButton = makeRoundButton(imageName: "smile", action: #selector(hanldePreviousCard))
    
    lazy var nextButton = makeRoundButton(imageName: "heart", action: #selector(hanldeNextCard))
    
    lazy var resettButton = makeRoundButton(imageName: "vibe", action: #selector(handleResetCard))
    
    private func makeRoundButton(imageName: String, action: Selector) -> UIButton
    {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        configuration.background.backgroundColor = .white
        configuration.background.cornerRadius = 35
        configuration.background.strokeColor = .gray
        configuration.background.strokeWidth = 1.5
        configuration.cornerStyle = .fixed
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.accessibilityIdentifier = imageName
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        kolodaView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,
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
        return cardView
    }
    
    func cardDeckDidRunOutOfCards(_ cardDeck: CardDeckView) {
        let title = "测试段落？"
        let message = "测试段落测试段落测试段落测试段落测试段落测试段落"
        let popup = UIAlertController(title: title, message: message, preferredStyle: .alert)
        popup.addAction(UIAlertAction(title: "I say yes", style: .default) { _ in
            self.sendEmail()
        })
        self.present(popup, animated: true, completion: nil)
    }
    
    func cardDeck(_ cardDeck: CardDeckView, didShowCardAt index: Int) {
        guard let cardView = cardDeck.topCard as? CardView else { return }
        cardView.contentTextField.resetTypeOn()
        cardView.contentTextField.typeOn(string: stories[index].storyContent)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("I say yes!")
            mail.setToRecipients(["xuxiang1990619@gmail.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            print("Cannot send email")
            kolodaView.resetCurrentCardIndex()
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        kolodaView.resetCurrentCardIndex()
    }
}

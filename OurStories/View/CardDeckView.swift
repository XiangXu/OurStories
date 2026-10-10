//
//  CardDeckView.swift
//  OurStories
//

import UIKit

protocol CardDeckViewDataSource: AnyObject
{
    func numberOfCards(in cardDeck: CardDeckView) -> Int
    func cardDeck(_ cardDeck: CardDeckView, viewForCardAt index: Int) -> UIView
}

protocol CardDeckViewDelegate: AnyObject
{
    func cardDeck(_ cardDeck: CardDeckView, didShowCardAt index: Int)
    func cardDeckDidRunOutOfCards(_ cardDeck: CardDeckView)
}

/// A stack of swipeable cards. The top card can be dragged off to either side,
/// and the cards behind it are shown slightly smaller and lower.
class CardDeckView: UIView
{
    enum SwipeDirection: CGFloat
    {
        case left = -1
        case right = 1
    }

    weak var dataSource: CardDeckViewDataSource?
    weak var delegate: CardDeckViewDelegate?

    private(set) var currentCardIndex = 0

    var topCard: UIView? {
        return visibleCards.first
    }

    // Front card first.
    private var visibleCards = [UIView]()
    private var numberOfCards = 0
    private var isDragging = false

    private let maxVisibleCards = 3
    private let backgroundCardScale: CGFloat = 0.95
    private let backgroundCardOffset: CGFloat = 12
    private let maxRotation: CGFloat = 0.3
    private let animationDuration: TimeInterval = 0.3

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        if !isDragging {
            layoutVisibleCards()
        }
    }

    func reloadData()
    {
        visibleCards.forEach { $0.removeFromSuperview() }
        visibleCards.removeAll()
        numberOfCards = dataSource?.numberOfCards(in: self) ?? 0
        currentCardIndex = min(currentCardIndex, numberOfCards)
        fillDeck()
        layoutVisibleCards()
        notifyCurrentCard()
    }

    func resetCurrentCardIndex()
    {
        currentCardIndex = 0
        reloadData()
    }

    func swipe(_ direction: SwipeDirection)
    {
        guard !visibleCards.isEmpty else { return }

        let card = visibleCards.removeFirst()
        currentCardIndex += 1
        fillDeck()

        let offscreen = CGAffineTransform(translationX: direction.rawValue * bounds.width * 1.6, y: card.transform.ty)
            .rotated(by: direction.rawValue * maxRotation)
        UIView.animate(withDuration: animationDuration, animations: {
            card.transform = offscreen
            self.layoutVisibleCards()
        }, completion: { _ in
            card.removeFromSuperview()
        })

        notifyCurrentCard()
    }

    func revertAction()
    {
        guard currentCardIndex > 0, let dataSource = dataSource else { return }

        currentCardIndex -= 1
        let card = dataSource.cardDeck(self, viewForCardAt: currentCardIndex)
        addSubview(card)
        visibleCards.insert(card, at: 0)
        if visibleCards.count > maxVisibleCards {
            visibleCards.removeLast().removeFromSuperview()
        }

        place(card, with: CGAffineTransform(translationX: -bounds.width * 1.6, y: 0).rotated(by: -maxRotation))
        UIView.animate(withDuration: animationDuration) {
            self.layoutVisibleCards()
        }

        notifyCurrentCard()
    }

    private func fillDeck()
    {
        guard let dataSource = dataSource else { return }

        while visibleCards.count < maxVisibleCards, currentCardIndex + visibleCards.count < numberOfCards {
            let position = visibleCards.count
            let card = dataSource.cardDeck(self, viewForCardAt: currentCardIndex + position)
            insertSubview(card, at: 0)
            visibleCards.append(card)
            // Start one step further back so the card grows into place when the deck advances.
            place(card, with: backgroundTransform(at: position + 1))
        }
    }

    private func layoutVisibleCards()
    {
        for (position, card) in visibleCards.enumerated() {
            place(card, with: backgroundTransform(at: position))
        }
    }

    private func place(_ card: UIView, with transform: CGAffineTransform)
    {
        card.transform = .identity
        card.frame = bounds
        card.transform = transform
    }

    private func backgroundTransform(at position: Int) -> CGAffineTransform
    {
        let scale = pow(backgroundCardScale, CGFloat(position))
        // Shift down by the height lost to scaling so the card's bottom edge peeks out below the one in front.
        let offset = CGFloat(position) * backgroundCardOffset + bounds.height * (1 - scale) / 2
        return CGAffineTransform(translationX: 0, y: offset).scaledBy(x: scale, y: scale)
    }

    private func notifyCurrentCard()
    {
        if visibleCards.isEmpty {
            if numberOfCards > 0 {
                delegate?.cardDeckDidRunOutOfCards(self)
            }
        } else {
            delegate?.cardDeck(self, didShowCardAt: currentCardIndex)
        }
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer)
    {
        guard let card = visibleCards.first, bounds.width > 0 else { return }

        let translation = gesture.translation(in: self)

        switch gesture.state {
        case .began, .changed:
            isDragging = true
            card.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
                .rotated(by: translation.x / bounds.width * maxRotation)
        case .ended:
            isDragging = false
            let velocity = gesture.velocity(in: self).x
            if abs(translation.x) > bounds.width * 0.3 {
                swipe(translation.x > 0 ? .right : .left)
            } else if abs(velocity) > 800 {
                swipe(velocity > 0 ? .right : .left)
            } else {
                springBack()
            }
        case .cancelled, .failed:
            isDragging = false
            springBack()
        default:
            break
        }
    }

    private func springBack()
    {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.layoutVisibleCards()
        }, completion: nil)
    }
}

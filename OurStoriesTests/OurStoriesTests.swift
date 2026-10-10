//
//  OurStoriesTests.swift
//  OurStoriesTests
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import XCTest
import CoreLocation
@testable import OurStories

class OurStoriesTests: XCTestCase {

    func testStoriesAreNotEmpty() {
        XCTAssertFalse(Story.storyGenerate().isEmpty)
    }

    func testEveryStoryHasText() {
        for story in Story.storyGenerate() {
            XCTAssertFalse(story.location.isEmpty)
            XCTAssertFalse(story.storyContent.isEmpty, "Missing text for \(story.location)")
        }
    }

    func testEveryStoryImageExists() {
        for story in Story.storyGenerate() {
            XCTAssertNotNil(UIImage(named: story.imageName), "Missing image \(story.imageName) for \(story.location)")
        }
    }

    func testEveryStoryCoordinateIsValid() {
        for story in Story.storyGenerate() {
            XCTAssertTrue(CLLocationCoordinate2DIsValid(story.coordinate), "Invalid coordinate for \(story.location)")
        }
    }

    func testTypeOnTypesOneCharacterPerTick() {
        XCTAssertEqual(TypeOnTextView.typeOnSteps(for: "我们的"), ["我", "们", "的"])
        XCTAssertEqual(TypeOnTextView.typeOnSteps(for: ""), [])
    }

    func testTypeOnDollarPausesWithoutPrinting() {
        let steps = TypeOnTextView.typeOnSteps(for: "a$$b")
        XCTAssertEqual(steps, ["a", "", "", "b"])
        XCTAssertEqual(steps.joined(), "ab")
    }

    func testTypeOnSpaceRunIsTypedWithNextCharacter() {
        XCTAssertEqual(TypeOnTextView.typeOnSteps(for: "a  b c"), ["a", "  b", " c"])
        XCTAssertEqual(TypeOnTextView.typeOnSteps(for: "a "), ["a", " "])
        XCTAssertEqual(TypeOnTextView.typeOnSteps(for: "a $b"), ["a", " ", "b"])
    }

    func testCardDeckWalksThroughAllCards() {
        let deck = CardDeckView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        let source = DeckSource(count: 4)
        deck.dataSource = source
        deck.delegate = source
        deck.reloadData()
        XCTAssertEqual(source.shown, [0])

        deck.swipe(.right)
        deck.swipe(.left)
        deck.revertAction()
        XCTAssertEqual(source.shown, [0, 1, 2, 1])
        XCTAssertEqual(deck.currentCardIndex, 1)

        deck.swipe(.right)
        deck.swipe(.right)
        XCTAssertFalse(source.ranOut)
        deck.swipe(.right)
        XCTAssertTrue(source.ranOut)
        XCTAssertNil(deck.topCard)

        deck.resetCurrentCardIndex()
        XCTAssertEqual(deck.currentCardIndex, 0)
        XCTAssertNotNil(deck.topCard)
    }
}

private class DeckSource: CardDeckViewDataSource, CardDeckViewDelegate {
    let count: Int
    var shown = [Int]()
    var ranOut = false

    init(count: Int) {
        self.count = count
    }

    func numberOfCards(in cardDeck: CardDeckView) -> Int {
        return count
    }

    func cardDeck(_ cardDeck: CardDeckView, viewForCardAt index: Int) -> UIView {
        return UIView()
    }

    func cardDeck(_ cardDeck: CardDeckView, didShowCardAt index: Int) {
        shown.append(index)
    }

    func cardDeckDidRunOutOfCards(_ cardDeck: CardDeckView) {
        ranOut = true
    }
}

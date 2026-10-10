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

    func testStoryDateDisplayText() {
        XCTAssertEqual(StoryDate(year: 2012, month: 7).displayText, "2012年7月")
        XCTAssertEqual(StoryDate(year: 2021, month: 7, day: 7).displayText, "2021年7月7日")
    }

    func testEveryStoryDateIsValid() {
        for story in Story.storyGenerate() {
            guard let date = story.date else { continue }
            XCTAssertTrue((1...12).contains(date.month), "Invalid month for \(story.location)")
            if let day = date.day {
                XCTAssertTrue((1...31).contains(day), "Invalid day for \(story.location)")
            }
        }
    }

    func testDatedStoriesAreInChronologicalOrder() {
        let months = Story.storyGenerate().compactMap { $0.date }.map { $0.year * 12 + $0.month }
        XCTAssertEqual(months, months.sorted())
    }

    // The date lives in `Story.date`; the text should not repeat it.
    func testStoryTextDoesNotStartWithDate() {
        for story in Story.storyGenerate() {
            XCTAssertNil(story.storyContent.range(of: "^\\d{4}年", options: .regularExpression),
                         "Move the date of \(story.location) into `date`")
        }
    }

    func testCardShowsDateOnlyForDatedStories() {
        let coordinate = CLLocationCoordinate2D(latitude: 53.38, longitude: -6.59)
        let card = CardView()
        card.story = Story(location: "爱尔兰-梅努斯", date: StoryDate(year: 2012, month: 7), storyContent: "故事", imageName: "ireland-maynooth", coordinate: coordinate)
        XCTAssertFalse(card.dateBadge.isHidden)
        XCTAssertEqual(card.dateBadge.configuration?.title, "2012年7月")

        card.story = Story(location: "爱尔兰-梅努斯", storyContent: "故事", imageName: "ireland-maynooth", coordinate: coordinate)
        XCTAssertTrue(card.dateBadge.isHidden)
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

//
//  OurStoriesUITests.swift
//  OurStoriesUITests
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import XCTest

class OurStoriesUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testBrowseStoriesAndOpenMap() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["我们的故事"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.staticTexts["爱尔兰-梅努斯"].exists)
        // Let the typewriter run for a while before capturing the first card.
        sleep(4)
        attachScreenshot(named: "1-first-card")

        app.buttons["next"].tap()
        sleep(3)
        attachScreenshot(named: "2-after-next-button")

        app.staticTexts["爱尔兰-都柏林"].firstMatch.swipeLeft()
        sleep(3)
        attachScreenshot(named: "3-after-swipe")

        app.buttons["previous"].tap()
        sleep(2)
        attachScreenshot(named: "4-after-previous-button")

        app.buttons["reset"].tap()
        sleep(2)
        attachScreenshot(named: "5-after-reset-button")

        app.buttons["map"].tap()
        XCTAssertTrue(app.navigationBars["我们的足迹"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.maps.firstMatch.exists)
        sleep(4)
        attachScreenshot(named: "6-map")
    }

    func testEndOfDeckStartsOver() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.navigationBars["我们的故事"].waitForExistence(timeout: 10))

        // The page badge of the first card reads "1 / <number of stories>".
        let firstPageBadge = app.buttons.matching(NSPredicate(format: "label BEGINSWITH '1 / '")).firstMatch
        XCTAssertTrue(firstPageBadge.exists)

        let nextButton = app.buttons["next"]
        nextButton.tap()
        XCTAssertFalse(firstPageBadge.exists)

        for _ in 0..<200 where !firstPageBadge.exists {
            nextButton.tap()
        }
        XCTAssertTrue(firstPageBadge.exists)
    }

    private func attachScreenshot(named name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

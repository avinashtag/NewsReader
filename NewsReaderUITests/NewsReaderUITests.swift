//
//  NewsReaderUITests.swift
//  NewsReaderUITests
//
//  Created by Avinash on 23/09/2024.
//

import XCTest

final class NewsReaderUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        app.terminate()
    }

    func waitFor(sec: Double) {
        let expectation = XCTestExpectation(description: "Wait for \(sec) second")
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: sec)
    }
    
    func takeScreenshot(_ description: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = description
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testTabBar(){
        let newsTab = app.tabBars.buttons.element(boundBy: 0)
        let bookmarkTab = app.tabBars.buttons.element(boundBy: 1)
        
//        let addPatientButton = app.navigationBars.buttons["person.fill.badge.plus"]
        XCTAssert(newsTab.exists, "\(TabBarView.self)- News Tab Missing")
        XCTAssert(bookmarkTab.exists, "\(TabBarView.self)- Bookmark Tab Missing")
        XCTAssert(newsTab.label == "News Feed", "\(TabBarView.self)- News Tab Wrong Title")
        XCTAssert(bookmarkTab.label == "Bookmark", "\(TabBarView.self)- News Tab Wrong Title")
    }
    
    func testCategoryView(){
        let category = app.scrollViews[NewsFeedViewAccesbilities.topCategory.rawValue]
        XCTAssert(category.exists , "\(TabBarView.self)- Category Segment Missing")
    }
    
    func testCategorySegments(){
        XCTAssert(app.buttons[SideTab.general.rawValue.capitalized].exists , "\(NewsFeedView.self)- \(SideTab.general.rawValue.capitalized) Category Segment Missing")
        XCTAssert(app.buttons[SideTab.business.rawValue.capitalized].exists , "\(NewsFeedView.self)- \(SideTab.business.rawValue.capitalized) Category Segment Missing")
        XCTAssert(app.buttons[SideTab.entertainment.rawValue.capitalized].exists , "\(NewsFeedView.self)- \(SideTab.entertainment.rawValue.capitalized) Category Segment Missing")
        XCTAssert(app.buttons[SideTab.health.rawValue.capitalized].exists , "\(NewsFeedView.self)- \(SideTab.health.rawValue.capitalized) Category Segment Missing")
        XCTAssert(app.buttons[SideTab.science.rawValue.capitalized].exists , "\(NewsFeedView.self)- \(SideTab.science.rawValue.capitalized) Category Segment Missing")
        XCTAssert(app.buttons[SideTab.technology.rawValue.capitalized].exists , "\(NewsFeedView.self)- \(SideTab.technology.rawValue.capitalized) Category Segment Missing")
        XCTAssert(app.buttons[SideTab.sports.rawValue.capitalized].exists , "\(NewsFeedView.self)- \(SideTab.sports.rawValue.capitalized) Category Segment Missing")
    }
    
    func testNewsFeeds(){
        let listView = app.collectionViews[NewsFeedViewAccesbilities.topHeadlineList.rawValue]
        XCTAssert(listView.exists , "\(NewsFeedView.self)- Article List missing")
    }
    
    func testNewsFeed(){
        let listView = app.collectionViews[NewsFeedViewAccesbilities.topHeadlineList.rawValue]
        let newsCell = listView.cells.element(boundBy: 1)
        XCTAssert(newsCell.exists , "\(NewsFeedView.self)- News Cell missing")
        
        XCTAssert(newsCell.staticTexts[NewsFeedCellAccesibility.newsFeedAuthor.rawValue].exists , "\(NewsFeedCell.self)- Author missing")
        XCTAssert(newsCell.staticTexts[NewsFeedCellAccesibility.newsFeedTitle.rawValue].exists , "\(NewsFeedCell.self)- Title missing")
        XCTAssert(newsCell.staticTexts[NewsFeedCellAccesibility.newsFeedDate.rawValue].exists , "\(NewsFeedCell.self)- Date missing")
        XCTAssert(newsCell.images[NewsFeedCellAccesibility.newsFeedImage.rawValue].exists , "\(NewsFeedCell.self)- Image missing")
        XCTAssert(newsCell.buttons[NewsFeedCellAccesibility.newsFeedBookmark.rawValue].exists , "\(NewsFeedCell.self)- Bookmark missing")
    }
    
    func testNewsFeedDetailView(){
        let listView = app.collectionViews[NewsFeedViewAccesbilities.topHeadlineList.rawValue]
        let newsCell = listView.cells.element(boundBy: 1)
        newsCell.tap()
        waitFor(sec: 5)
        XCTAssert(app.staticTexts[NewsReaderViewAccesibility.newsFeedAuthor.rawValue].exists , "\(NewsReaderView.self)- Author missing")
        XCTAssert(app.staticTexts[NewsReaderViewAccesibility.newsFeedTitle.rawValue].exists , "\(NewsReaderView.self)- Title missing")
        XCTAssert(app.staticTexts[NewsReaderViewAccesibility.newsFeedDate.rawValue].exists , "\(NewsReaderView.self)- Date missing")
        XCTAssert(app.staticTexts[NewsReaderViewAccesibility.newsFeedDescription.rawValue].exists , "\(NewsReaderView.self)- Description missing")
        XCTAssert(app.buttons[NewsReaderViewAccesibility.newsFeedBookmark.rawValue].exists , "\(NewsReaderView.self)- Bookmark missing")
    }
    
    func testReadMoreButton() {
        let listView = app.collectionViews[NewsFeedViewAccesbilities.topHeadlineList.rawValue]
        let newsCell = listView.cells.element(boundBy: 1)
        newsCell.tap()
        waitFor(sec: 5)
        let readMore = app.buttons[NewsReaderViewAccesibility.newsFeedReadMore.rawValue]
        XCTAssert(readMore.exists , "\(NewsReaderView.self)- Read More missing")
    }
    
    func testSafariView() {
        
        let listView = app.collectionViews[NewsFeedViewAccesbilities.topHeadlineList.rawValue]
        let newsCell = listView.cells.element(boundBy: 1)
        newsCell.tap()
        waitFor(sec: 5)
        let readMore = app.buttons[NewsReaderViewAccesibility.newsFeedReadMore.rawValue]
        readMore.tap()
        waitFor(sec: 2)
        XCTAssert(app.otherElements[NewsReaderViewAccesibility.newsFeedSafariView.rawValue].exists , "\(SafariView.self)- SafariView missing")

    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

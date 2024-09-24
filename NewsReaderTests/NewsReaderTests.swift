//
//  NewsReaderTests.swift
//  NewsReaderTests
//
//  Created by Avinash on 23/09/2024.
//

import XCTest
@testable import NewsReader

final class NewsReaderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNewsFeed() async throws{
        do{
            let request = NewsFeedRequest()
            let response = try await request.load()
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.articles.count, 0, "News Feed Empty")
        }
        catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testBusinessNewsFeed() async throws{
        do{
            let response = try await news(category: .business)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.articles.count, 0, "News Feed Empty")
        }
        catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testEntertainmentNewsFeed() async throws{
        do{
            let response = try await news(category: .entertainment)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.articles.count, 0, "News Feed Empty")
        }
        catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGeneralNewsFeed() async throws{
        do{
            let response = try await news(category: .general)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.articles.count, 0, "News Feed Empty")
        }
        catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testHealthNewsFeed() async throws{
        do{
            let response = try await news(category: .health)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.articles.count, 0, "News Feed Empty")
        }
        catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testScienceNewsFeed() async throws{
        do{
            let response = try await news(category: .science)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.articles.count, 0, "News Feed Empty")
        }
        catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSportsNewsFeed() async throws{
        do{
            let response = try await news(category: .sports)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.articles.count, 0, "News Feed Empty")
        }
        catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testTechnologyNewsFeed() async throws{
        do{
            let response = try await news(category: .technology)
            XCTAssertEqual(response.status, "ok")
            XCTAssertGreaterThan(response.articles.count, 0, "News Feed Empty")
        }
        catch{
            XCTFail(error.localizedDescription)
        }
    }


    
    func news(category: SideTab) async throws -> NewsFeedResponse{
        var request = NewsFeedRequest()
        request.category = category.rawValue
        return try await request.load()
    }


    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

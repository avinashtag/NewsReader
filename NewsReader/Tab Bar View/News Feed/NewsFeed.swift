//
//  NewsFeed.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation
import SwiftData

struct NewsFeedRequest:Codable{
    
    var category: String?
    var pagesize: Int64 = 50
    var page: Int64 = 1
    var availablePages: Int64 = 1

    enum CodingKeys: String, CodingKey {
        case category = "category"
        case pagesize = "pageSize"
        case page = "page"
    }
    
    public func load() async throws -> NewsFeedResponse{
      
//        throw APIError.offline
        #if DEBUG
        return try Bundle.main.decoder("Sample.json", of: NewsFeedResponse.self)
        #endif
        var endpoint = NewsFeedEndpoint.newsTopHeadlines
        endpoint.query[NewsFeedRequest.CodingKeys.pagesize.rawValue] = "\(pagesize)"
        endpoint.query[NewsFeedRequest.CodingKeys.page.rawValue] = "\(page)"
        if let category = category{ endpoint.query[NewsFeedRequest.CodingKeys.category.rawValue] = category }
        let response: NewsFeedResponse = try await Network.shared.fetch(for: endpoint)
        return response
    }

}

struct NewsFeedResponse: Codable {
    let status: String
    let articles: [Article]
    let totalResults : Int64
}

struct Article: Codable, Hashable {
    let source: ArticleSource?
    let author: String?
    let title: String?
    let description: String?
    let url: URL
    let urlToImage: String?
    let publishedAt: Date?
}

extension Article{
    func bookmark( _ isBookmark: Bool, modelContext: ModelContext){
        if isBookmark{
            modelContext.insert(BookmarkArticle(article: self))
        }
        else{
            try? modelContext.delete(model: BookmarkArticle.self, where: #Predicate { bookmarkedArticle in
                bookmarkedArticle.url == self.url
            })
        }
    }

}

struct ArticleSource: Codable, Hashable {
    let id: String?
    let name: String?
}

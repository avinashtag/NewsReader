//
//  BookmarkArticle.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation
import SwiftData

@Model
final class BookmarkArticle {
   
    let source: ArticleSource?
    let author: String?
    let title: String?
    let detail: String?
    @Attribute(.unique) let url: URL
    let urlToImage: String?
    let publishedAt: Date?
    
    init(source: ArticleSource?, author: String?, title: String?, detail: String?, url: URL, urlToImage: String?, publishedAt: Date?) {
        self.source = source
        self.author = author
        self.title = title
        self.detail = detail
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
    convenience init(article: Article) {
        self.init(source: article.source, author: article.author, title: article.title, detail: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt)
    }
    
    func parse()->Article {
        return Article(source: self.source, author: self.author, title: self.title, description: self.detail, url: self.url, urlToImage: self.urlToImage, publishedAt: self.publishedAt)
    }


}

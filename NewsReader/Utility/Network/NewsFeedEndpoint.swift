//
//  NewsFeedEndpoint.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation

enum NewsFeedEndpoint: String{
    case newsTopHeadlines = "top-headlines"
}

extension NewsFeedEndpoint: EndpointProtocol {
    
    struct QueryKeeper { static var _query:[String: String] = ["country": "us"]}
    struct HeaderKeeper { static var _headers:[String : String] = [ "X-Api-Key": APIContent.newsFeedAPIKey,
                                                                    APIContent.type: APIContent.json,
                                                                    "Accept": APIContent.json ] }
    
    var baseURL: String { return "https://newsapi.org" }
    var path: String { return self.rawValue }
    
    var query: [String: String] {
        get { return QueryKeeper._query }
        set (newValue) { QueryKeeper._query = newValue }
    }
    
    var headers: [String : String]{
        get { return HeaderKeeper._headers }
        set (newValue) { HeaderKeeper._headers = newValue }
    }
}

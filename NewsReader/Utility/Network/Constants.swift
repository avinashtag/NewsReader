//
//  Constants.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation

enum HTTPMethod : String {
    case POST = "POST"
    case PUT = "PUT"
    case DEL = "DELETE"
    case GET = "GET"
}

struct APIContent{
    static let type = "Content-Type"
    static let json = "application/json"
    static let newsFeedAPIKey = "a859cb9819a44c7bb7643f1db7ae13c6"
}

enum TestingIdentifier: String{
    case test = "Test"
}

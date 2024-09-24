//
//  EndpointProtocol.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation

protocol EndpointProtocol {
    var locale: String { get }
    var region: String { get }
    var baseURL: String { get }
    var path: String { get }
    var query: [String: String] { get set }
    var headers: [String: String] { get set }
}

extension EndpointProtocol {
    var locale: String { return Locale.current.language.languageCode?.identifier ?? "en" }
    
    var region: String { return Locale.current.region?.identifier ?? "us" }
}

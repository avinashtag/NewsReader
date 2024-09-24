//
//  APIResponse.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation

struct NewsViewError{
    var showError: Bool
    var message: String
}

enum APIResponse<T, U> where U: Error  {
    case success(T, Int)
    case failure(U)
}

enum APIError: Int, LocalizedError {
    
    case badRequest = 400
    case unAuthorized = 401
    case tooManyRequests = 429
    case serverError = 500
    case offline = -1009
    
    var errorDescription: String? {
        switch self {
        case .badRequest: return "The request could not be processed, typically because of a missing or incorrectly configured parameter.".localized()
        case .unAuthorized: return "The API key was either missing from the request or invalid.".localized()
        case .tooManyRequests: return "You have exceeded the allowed number of requests within a given time frame and have been rate-limited. Please pause and try again later.".localized()
        case .serverError: return "An error occurred on the server side.".localized()
        case .offline: return "It seems the Internet connection is offline.".localized()
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case dataNil
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .dataNil:
            return "Empty data.".localized()
        case .decodingError:
            return "Data has invalid format.".localized()
        default:
            return "An error occurred.".localized()
        }
    }
}

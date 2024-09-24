//
//  Network.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation

class Network: NSObject, URLSessionTaskDelegate {
    
    static let shared = Network() 
    var urlSession: URLSession = URLSession.shared

    func fetch<T: Decodable>(for endpopint: NewsFeedEndpoint, method: HTTPMethod? = .GET, body: Encodable? = nil)async throws-> T  {
        
         var components = URLComponents(string: endpopint.baseURL) //else { throw NetworkError.invalidURL }
        components?.path = "/v2/\(endpopint.path)"
        components?.queryItems = endpopint.query.compactMap({URLQueryItem(name: $0.key, value: $0.value)})
        guard let url = components?.url else { throw NetworkError.invalidURL }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpopint.headers
        request.cachePolicy = request.httpMethod == HTTPMethod.GET.rawValue ? .reloadRevalidatingCacheData : .reloadIgnoringCacheData
        request.httpMethod = method?.rawValue ?? HTTPMethod.GET.rawValue
     
        if let body = body{ request.httpBody = try JSONEncoder().encode(body) }
     
        let (responseData, _) = try await urlSession.data(for: request, delegate: self)
        
        let jsonDecoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        let response = try jsonDecoder.decode(T.self, from: responseData)
        
#if DEBUG
        print("<URL:><\(url.absoluteString)>\n<Headers:><\(endpopint.headers)>\n")
        if let body = request.httpBody{
            let b = String(data: body, encoding: .utf8)?.replacingOccurrences(of: "\\", with: "")
            print("<Body:><\(b ?? "NULL")>\n")
        }
        let f = String(data: responseData, encoding: .utf8)?.replacingOccurrences(of: "\\", with: "")
        print("<Response:><\(f ?? "NULL")>")
#endif
        
        return response
    }
}

//
//  String+Extension.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

extension Bundle{
    
    func decoder<T:Decodable>(_ filename: String, of type: T.Type )throws  -> T {
        
        guard let url = self.url(forResource: filename, withExtension: nil) else { throw NetworkError.invalidURL }
        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        let decodable = try jsonDecoder.decode(T.self, from: data)

        return decodable
    }

}

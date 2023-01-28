//
//  NetworkRepository.swift
//  Data
//
//  Created by Dmytro Yurchenko on 03.02.2022.
//

import Foundation
import Combine

public protocol NetworkRepository {
    func executeRequest<R: Decodable>(for url: URL) -> AnyPublisher<R, Error>
}

public final class RealNetworkRepository: NetworkRepository {
    let decoder = JSONDecoder()
    
    public init() {}
    
    public func executeRequest<R: Decodable>(for url: URL) -> AnyPublisher<R, Error> {
        let session = URLSession(configuration: .default)
        
        return session.dataTaskPublisher(for: url)
            .retry(1)
            .map { $0.data }
            .printPrettyJSON()
            .decode(type: R.self, decoder: decoder)
            .mapError({ error in
                
#if DEBUG
                if case DecodingError.dataCorrupted(let context) = error {
                    print(context)
                } else if case DecodingError.keyNotFound(let key, let context) = error {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } else if case DecodingError.valueNotFound(let value, let context) = error {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } else if case DecodingError.typeMismatch(let type, let context) = error {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                }
#endif
                
                return error
            })
            .eraseToAnyPublisher()
    }
}

extension Publisher where Output == Data {
    func printPrettyJSON() -> Publishers.Map<Self, Data> {
        map { data in
            if let jsonObject = try? JSONSerialization.jsonObject(with: data),
               let prettyPrintedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyPrintedString = NSString(data: prettyPrintedData, encoding: String.Encoding.utf8.rawValue) {
                
                #if DEBUG
                Swift.print(prettyPrintedString)
                #endif
            }
            
            return data
        }
    }
}

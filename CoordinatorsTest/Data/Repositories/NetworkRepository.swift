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
            .map {
                let data = $0.data
                
#if DEBUG
                print("Request: ", url)
                print(data.prettyPrintedJSON)
#endif
                
                return data
            }
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
private extension Data {
    var prettyPrintedJSON: NSString {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
              let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        else { return "" }
        
        return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? ""
    }
}

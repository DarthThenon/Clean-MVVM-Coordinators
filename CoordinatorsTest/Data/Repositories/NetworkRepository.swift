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
            .eraseToAnyPublisher()
    }
}

extension Publisher where Output == Data {
    func printPrettyJSON() -> Publishers.Map<Self, Data> {
        map { data in
            if let jsonObject = try? JSONSerialization.jsonObject(with: data),
               let prettyPrintedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyPrintedString = NSString(data: prettyPrintedData, encoding: String.Encoding.utf8.rawValue) {
                
                Swift.print(prettyPrintedString)
            }
            
            return data
        }
    }
}

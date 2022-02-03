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
            .decode(type: R.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

//
//  MockNetworkRepository.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import Foundation
import Combine
@testable import Data

final class MockNetworkRepository<Response: Decodable>: NetworkRepository {
    var error: Error?
    var value: Response?
    
    func executeRequest<R>(for url: URL) -> AnyPublisher<R, Error> where R : Decodable {
        if let value = value as? R {
            return Just(value)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else if let error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return Fail(error: makeError())
            .eraseToAnyPublisher()
    }
}
 

//
//  StubProvider.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import Foundation

final class StubProvider {
    private static let shared: StubProvider = .init()
    
    let bundle: Bundle
    let decoder = JSONDecoder()
    
    private init() {
        bundle = Bundle(for: Self.self)
    }
    
    static func makeStubObject<T: Decodable>(jsonFileName fileName: String) throws -> T {
        let bundle = StubProvider.shared.bundle
        let decoder = StubProvider.shared.decoder
        
        guard let url = bundle.url(forResource: fileName, withExtension: "json")
        else {
            throw NSError(domain: "", code: 0)
        }
        
        let data = try Data(contentsOf: url)
    
        return try decoder.decode(T.self, from: data)
    }
}

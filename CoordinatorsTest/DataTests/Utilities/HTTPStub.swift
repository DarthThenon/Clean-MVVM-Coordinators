//
//  MockURLSession.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import Foundation

extension URLSessionConfiguration {
    static var stubbed: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.ephemeral
        
        configuration.protocolClasses = [MockURLProtocol.self]
        
        return configuration
    }
}

enum HTTPStub {
    static func stub<T: Encodable>(url: URL, withObject object: T, andResponse response: URLResponse? = nil) {
        let stub = Stub.init(data: try? JSONEncoder().encode(object), response: response, error: nil)
        
        MockURLProtocol.stub(url: url, withStub: stub)
    }

    static func stub(url: URL, withResponse response: URLResponse?) {
        let stub = Stub.init(data: nil, response: response, error: nil)
        
        MockURLProtocol.stub(url: url, withStub: stub)
    }

    static func stub(url: URL, withError error: Error) {
        let stub = Stub(data: nil, response: nil, error: error)
        
        MockURLProtocol.stub(url: url, withStub: stub)
    }
}

private struct Stub {
    let data: Data?
    let response: URLResponse?
    let error: Error?
}

fileprivate final class MockURLProtocol: URLProtocol {
    private static var stubs: [URL: Stub] = [:]
    
    fileprivate static func stub(url: URL, withStub stub: Stub) {
        stubs[url] = stub
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        guard let url = request.url else { return false }
        
        return stubs[url] != nil
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        guard let url = request.url,
              let stub = MockURLProtocol.stubs.removeValue(forKey: url) else {
            assertionFailure()
            return
        }
        
        handleStub(stub)
    }
    
    override func stopLoading() {}
    
    private func handleStub(_ stub: Stub) {
        stub.error.flatMap {
            client?.urlProtocol(self, didFailWithError: $0)
        }
        stub.data.flatMap {
            client?.urlProtocol(self, didLoad: $0)
        }
        stub.response.flatMap {
            client?.urlProtocol(self, didReceive: $0, cacheStoragePolicy: .notAllowed)
        }
        
        guard stub.error == nil else {
            return
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
}

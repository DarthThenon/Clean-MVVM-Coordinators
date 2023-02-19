//
//  NetworkRepositoryTests.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import XCTest
import Combine
@testable import Data

final class NetworkRepositoryTests: XCTestCase {
    func test_getResponseObject() throws {
        let sut = makeSut()
        let url = makeGoogleURL()
        let categoriesStub = try stub(makeStubBlock: makeCategoriesContainerStub, for: url)
        
        let response: MealCategoryContainerCodable = awaitForResponse(in: sut.executeRequest(for: url))
        
        XCTAssertNotNil(response)
        XCTAssertEqual(categoriesStub, response)
    }
    
    func test_getError() throws {
        let sut = makeSut()
        let url = makeGoogleURL()
        let publisher: AnyPublisher<MealCategoryContainerCodable, Error> = sut.executeRequest(for: url)
        
        HTTPStub.stub(url: url, withError: makeError())
        
        XCTAssertThrowsError(try awaitForError(in: publisher))
    }
}

private extension NetworkRepositoryTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> RealNetworkRepository {
        let urlSession = makeStubbedURLSession()
        let sut = RealNetworkRepository(session: urlSession)
        
        deallocationCheck(sut, file: file, line: line)
        
        return sut
    }
    
    func stub<T: Encodable>(makeStubBlock: () throws -> T, for url: URL) throws -> T {
        let stubResponse = try makeStubBlock()
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        
        HTTPStub.stub(url: url, withObject: stubResponse, andResponse: urlResponse)
        
        return stubResponse
    }
    
    func awaitForResponse<T: Decodable>(in requestPublisher: AnyPublisher<T, Error>) -> T {
        let expectation = expectation(description: "com.networkRepository.test.responseExpectation")
        var response: T!
        let cancellable = requestPublisher
            .sink(receiveCompletion: {
                guard case .failure(let error) = $0
                else { return }
                
                XCTFail(error.localizedDescription)
            }, receiveValue: {
                response = $0
                
                expectation.fulfill()
            })
        
        wait(for: [expectation], timeout: 2)
        
        cancellable.cancel()
        
        return response
    }
    
    func awaitForError<T: Decodable>(in requestPublisher: AnyPublisher<T, Error>) throws {
        let expectation = expectation(description: "com.networkRepository.test.errorExpectation")
        var error: Error!
        let cancellable = requestPublisher
            .sink(receiveCompletion: {
                guard case .failure(let completionError) = $0
                else { return }
                
                error = completionError
                
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail()
            })
        
        wait(for: [expectation], timeout: 2)
        
        cancellable.cancel()
        
        throw error
    }
}

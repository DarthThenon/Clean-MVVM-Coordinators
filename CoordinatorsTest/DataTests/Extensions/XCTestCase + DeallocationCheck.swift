//
//  XCTestCase + DeallocationCheck.swift
//  DataTests
//
//  Created by Dmitriy Yurchenko on 19.02.2023.
//

import Foundation
import XCTest

extension XCTestCase {
    func deallocationCheck(_ object: AnyObject,
                           file: StaticString = #file,
                           line: UInt = #line) {
        
        addTeardownBlock { [weak object] in
            XCTAssertNil(object, "The object has not been deallocated", file: file, line: line)
        }
    }
}

//
//  NetworkRepositoryError.swift
//  Data
//
//  Created by Dmitriy Yurchenko on 26.02.2023.
//

import Foundation

enum NetworkRepositoryError: LocalizedError {
    case searchIsNotAvailable
    
    var errorDescription: String? {
        switch self {
        case .searchIsNotAvailable:
            return "Search feature is not available within a network repository"
        }
    }
}

//
//  MovieError.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndpoint

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data."
        case .invalidEndpoint: return "Invalid endpoint."
        }
    }

    var errorUserInfo: [String: Any] {
        return [NSLocalizedDescriptionKey: self.localizedDescription]
    }
}

enum DatabaseError: Error, CustomNSError {

  case invalidInstance
  case requestFailed

  var localizedDescription: String {
    switch self {
    case .invalidInstance: return "Cannot instantiate the database."
    case .requestFailed: return "Your request failed."
    }
  }
    var errorUserInfo: [String: Any] {
        return [NSLocalizedDescriptionKey: self.localizedDescription]
    }
}

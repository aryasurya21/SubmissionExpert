//
//  MovieError.swift
//  Nonton
//
//  Created by IT Division on 05/12/20.
//

import Foundation

public enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndpoint

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data."
        case .invalidEndpoint: return "Invalid endpoint."
        }
    }

    public var errorUserInfo: [String: Any] {
        return [NSLocalizedDescriptionKey: self.localizedDescription]
    }
}

public enum DatabaseError: Error, CustomNSError {

  case invalidInstance
  case requestFailed

  var localizedDescription: String {
    switch self {
    case .invalidInstance: return "Cannot instantiate the database."
    case .requestFailed: return "Your request failed."
    }
  }
    public var errorUserInfo: [String: Any] {
        return [NSLocalizedDescriptionKey: self.localizedDescription]
    }
}

//
//  UseCase.swift
//  NCore
//
//  Created by IT Division on 05/12/20.
//

import Foundation
import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(endpoint: MovieEndPoints, request: Request?) -> AnyPublisher<Response, Error>
}

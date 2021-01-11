//
//  DataSource.swift
//  NCore
//
//  Created by IT Division on 05/12/20.
//

import Foundation
import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
}

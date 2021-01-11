//
//  Interactor.swift
//  NCore
//
//  Created by IT Division on 05/12/20.
//

import Foundation
import Combine

public struct Interactor<Request, Response, R: Repository>: UseCase where R.Request == Request, R.Response == Response {
    private let repository: R

    public init(_ repository: R) {
        self.repository = repository
    }

    public func execute(endpoint: MovieEndPoints, request: Request?) -> AnyPublisher<Response, Error> {
        self.repository.execute(endpoint: endpoint, request: request)
    }
}

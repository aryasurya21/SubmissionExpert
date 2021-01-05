//
//  LocaleDataSource.swift
//  NCore
//
//  Created by IT Division on 05/12/20.
//

import Foundation
import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func update(id: String, entity: Response) -> AnyPublisher<Bool, Error>
    func toggle(id: Int) -> AnyPublisher<Response, Error>
}

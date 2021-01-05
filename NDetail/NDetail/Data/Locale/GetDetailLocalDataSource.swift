//
//  GetDetailLocalDataSource.swift
//  NDetail
//
//  Created by IT Division on 10/12/20.
//

import Foundation
import NCore
import Combine
import RealmSwift

public struct GetDetailLocalDataSource: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = DetailModuleEntity
    
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
   
    public func get(id: String) -> AnyPublisher<DetailModuleEntity, Error> {
        return Future<DetailModuleEntity, Error> { (completion) in
            let movies  = realm.objects(DetailModuleEntity.self)
                    .filter("id=\(id)")

            guard let targetMeal = movies.first else { return completion(.failure(DatabaseError.requestFailed))}
            completion(.success(targetMeal))
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: DetailModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func toggle(id: Int) -> AnyPublisher<DetailModuleEntity, Error> {
        fatalError()
    }
    
    public func list(request: Any?) -> AnyPublisher<[DetailModuleEntity], Error> {
        fatalError()
    }
    
    public func add(entities: [DetailModuleEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}

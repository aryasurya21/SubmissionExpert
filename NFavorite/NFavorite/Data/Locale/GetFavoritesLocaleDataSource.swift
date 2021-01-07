//
//  GetFavoritesLocaleDataSource.swift
//  NFavorite
//
//  Created by IT Division on 07/12/20.
//

import Foundation
import NCore
import RealmSwift
import Combine

public struct GetFavoritesLocaleDataSource: LocaleDataSource {

    public typealias Request = Any
    public typealias Response = FavoriteModuleEntity
    
    private let realm: Realm
    
    public init(_ realm: Realm){
        self.realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[FavoriteModuleEntity], Error> {
        return Future<[FavoriteModuleEntity], Error> { (completion) in
            let movies: Results<FavoriteModuleEntity> = {
                realm.objects(FavoriteModuleEntity.self)
                    .filter("isFavorite=\(true)")
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(movies.toCustomObjects(fromType: FavoriteModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func toggle(id: Int) -> AnyPublisher<FavoriteModuleEntity, Error> {
        return Future<FavoriteModuleEntity, Error> { (completion) in
            guard
                let targetMovie = self.realm.objects(FavoriteModuleEntity.self).filter("id=\(id)").first
            else {
                return completion(.failure(DatabaseError.invalidInstance))
            }
            do {
                try realm.write {
                    targetMovie.setValue(!targetMovie.isFavorite, forKey: "isFavorite")
                }
                completion(.success(targetMovie))
            } catch {
                return completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }

    public func add(entities: [FavoriteModuleEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: String) -> AnyPublisher<FavoriteModuleEntity, Error> {
        fatalError()
    }

    public func update(id: String, entity: FavoriteModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }    
}

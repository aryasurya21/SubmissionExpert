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
    public typealias Response = MovieEntity

    private let realm: Realm

    public init(_ realm: Realm) {
        self.realm = realm
    }

    public func list(endpoint: MovieEndPoints) -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { (completion) in
            let movies: Results<MovieEntity> = {
                realm.objects(MovieEntity.self)
                    .filter("isFavorite=\(true)")
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(movies.toCustomObjects(fromType: MovieEntity.self)))
        }.eraseToAnyPublisher()
    }

    public func toggle(id: Int) -> AnyPublisher<MovieEntity, Error> {
        return Future<MovieEntity, Error> { (completion) in
            guard
                let targetMovie = self.realm.objects(MovieEntity.self).filter("id=\(id)").first
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

    public func add(entities: [MovieEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }

    public func get(id: Int) -> AnyPublisher<MovieEntity, Error> {
        fatalError()
    }

    public func update(id: String, entity: MovieEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}

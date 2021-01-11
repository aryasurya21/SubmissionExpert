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

    public func get(id: Int) -> AnyPublisher<DetailModuleEntity, Error> {
        return Future<DetailModuleEntity, Error> { (completion) in
            let movies  = realm.objects(DetailModuleEntity.self)
                    .filter("id=\(id)")
            print(movies)
            guard let targetMeal = movies.first else { return completion(.failure(DatabaseError.requestFailed))}
            completion(.success(targetMeal))
        }.eraseToAnyPublisher()
    }

    public func update(id: String, entity: DetailModuleEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { (completion) in
            guard
                let targetMovie = self.realm.objects(DetailModuleEntity.self).filter("id=\(id)").first
            else {
                return completion(.failure(DatabaseError.invalidInstance))
            }
            do {
                try realm.write {
                    targetMovie.setValue(entity.title, forKey: "title")
                    targetMovie.setValue(entity.overview, forKey: "overview")
                    targetMovie.setValue(entity.posterPath, forKey: "posterPath")
                    targetMovie.setValue(entity.backdropPath, forKey: "backdropPath")
                    targetMovie.setValue(entity.voteAverage, forKey: "voteAverage")
                    targetMovie.setValue(entity.runtime, forKeyPath: "runtime")
                    targetMovie.setValue(entity.movieCategory, forKey: "movieCategory")
                    targetMovie.setValue(entity.releaseDate, forKey: "releaseDate")
                }
                completion(.success(true))
            } catch {
                return completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }

    public func toggle(id: Int) -> AnyPublisher<DetailModuleEntity, Error> {
        return Future<DetailModuleEntity, Error> { (completion) in
            guard let targetMovie = realm.objects(DetailModuleEntity.self).filter("id=\(id)").first
            else {
                return completion(.failure(DatabaseError.requestFailed))
            }
            do {
                try self.realm.write {
                    targetMovie.setValue(!targetMovie.isFavorite, forKey: "isFavorite")
                }
                completion(.success(targetMovie))
            } catch {
                return completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }

    public func list(endpoint: MovieEndPoints) -> AnyPublisher<[DetailModuleEntity], Error> {
        fatalError()
    }

    public func add(entities: [DetailModuleEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}

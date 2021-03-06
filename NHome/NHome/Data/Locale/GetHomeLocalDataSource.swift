//
//  GetHomeLocalDataSource.swift
//  NHome
//
//  Created by IT Division on 11/01/21.
//

import Foundation
import NCore
import Combine
import RealmSwift

public struct GetHomeLocalDataSource: LocaleDataSource {

    public typealias Request = Any
    public typealias Response = MovieEntity

    private let realm: Realm

    public init(realm: Realm) {
        self.realm = realm
    }

    public func get(id: Int) -> AnyPublisher<MovieEntity, Error> {
        return Future<MovieEntity, Error> { (completion) in
            let movies  = realm.objects(MovieEntity.self)
                    .filter("id=\(id)")
            print(movies)
            guard let targetMeal = movies.first else { return completion(.failure(DatabaseError.requestFailed))}
            completion(.success(targetMeal))
        }.eraseToAnyPublisher()
    }

    public func update(id: String, entity: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { (completion) in
            guard
                let targetMovie = self.realm.objects(MovieEntity.self).filter("id=\(id)").first
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

    public func toggle(id: Int) -> AnyPublisher<MovieEntity, Error> {
        fatalError()
    }

    public func list(endpoint: MovieEndPoints) -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { (completion) in
            let movies: Results<MovieEntity> = {
                realm.objects(MovieEntity.self)
                    .filter("movieCategory='\(endpoint.rawValue)'")
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(movies.toCustomObjects(fromType: MovieEntity.self)))
        }.eraseToAnyPublisher()
    }

    public func add(entities: [MovieEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { (completion) in
            do {
                let existingMovies = realm.objects(MovieEntity.self)

                let filteredMovies = entities.filter { apiMovie in
                    return !existingMovies.contains(where: { localMovie in
                        return apiMovie.id == localMovie.id
                    })
                }

                try realm.write {
                    for movie in filteredMovies {
                        realm.add(movie)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}

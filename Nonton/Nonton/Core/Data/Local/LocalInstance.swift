//
//  LocalInstance.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation
import Combine
import RealmSwift
import NCore

protocol LocalInstanceCapabilityProtocol {
    func getMovieList(from endpoint: MovieEndPoints) -> AnyPublisher<[MovieEntity], Error>
    func addMovieList(movies: [MovieEntity]) -> AnyPublisher<Bool, Error>
    func getMovieDetail(withID movieID: Int) -> AnyPublisher<MovieEntity, Error>
    func updateMovie(withID movieID: Int, newMovieData sourceMovie: MovieEntity) -> AnyPublisher<Bool, Error>
    func toggleFavoriteMovie(withID movieID: Int) -> AnyPublisher<MovieEntity, Error>
    func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error>
}

class LocalInstance {

    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }

    static let shared: (Realm?) -> LocalInstance = { realm in
        return LocalInstance(realm: realm)
    }
}

extension LocalInstance: LocalInstanceCapabilityProtocol {
    func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { (completion) in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter("isFavorite=\(true)")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(movies.toCustomObjects(fromType: MovieEntity.self)))
            } else {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }

    func toggleFavoriteMovie(withID movieID: Int) -> AnyPublisher<MovieEntity, Error> {
        return Future<MovieEntity, Error> { (completion) in
            guard
                let realm = self.realm,
                let targetMovie = realm.objects(MovieEntity.self).filter("id=\(movieID)").first
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

    func updateMovie(withID movieID: Int, newMovieData sourceMovie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { (completion) in
            guard
                let realm = self.realm,
                let targetMovie = realm.objects(MovieEntity.self).filter("id=\(movieID)").first
            else {
                return completion(.failure(DatabaseError.invalidInstance))
            }
            do {
                try realm.write {
                    targetMovie.setValue(sourceMovie.title, forKey: "title")
                    targetMovie.setValue(sourceMovie.overview, forKey: "overview")
                    targetMovie.setValue(sourceMovie.posterPath, forKey: "posterPath")
                    targetMovie.setValue(sourceMovie.backdropPath, forKey: "backdropPath")
                    targetMovie.setValue(sourceMovie.voteAverage, forKey: "voteAverage")
                    targetMovie.setValue(sourceMovie.runtime, forKeyPath: "runtime")
                    targetMovie.setValue(sourceMovie.movieCategory, forKey: "movieCategory")
                    targetMovie.setValue(sourceMovie.releaseDate, forKey: "releaseDate")
                }
                completion(.success(true))
            } catch {
                return completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }

    func getMovieDetail(withID movieID: Int) -> AnyPublisher<MovieEntity, Error> {
        return Future<MovieEntity, Error> { (completion) in
            if let realm = self.realm {
                let meals  = realm.objects(MovieEntity.self)
                    .filter("id=\(movieID)")

                guard let targetMeal = meals.first else { return completion(.failure(DatabaseError.requestFailed))}
                completion(.success(targetMeal))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }

    func getMovieList(from endpoint: MovieEndPoints) -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { (completion) in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter("movieCategory='\(endpoint.rawValue)'")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(movies.toCustomObjects(fromType: MovieEntity.self)))
            } else {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }

    func addMovieList(movies: [MovieEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { (completion) in
            if let realm = self.realm {
                do {
                    let existingMovies = {
                        realm.objects(MovieEntity.self)
                        .toCustomObjects(fromType: MovieEntity.self)
                    }()

                    let filteredMovies = movies.filter { apiMovie in
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
            } else {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}

extension LocalInstance {
    func getPrevEndPoint(currentEndPoint: MovieEndPoints) -> MovieEndPoints {
        switch currentEndPoint {
        case .popular:
            return .nowPlaying
        case .topRated:
            return .popular
        case .upcoming:
            return .topRated
        case .nowPlaying:
            return .nowPlaying
        }
    }
}

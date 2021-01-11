//
//  HomeTransformer.swift
//  NHome
//
//  Created by IT Division on 11/01/21.
//

import Foundation
import RealmSwift
import NCore

public struct HomeTransformer: Mapper {
   
    public typealias Response = MovieResponse
    public typealias Entity = HomeModuleEntity
    public typealias Domain = HomeDomainModel

    public init() {}

    public func transformResponseToEntities(from endpoint: MovieEndPoints, list: [MovieResponse]) -> [HomeModuleEntity] {
        return list.map { movie in
            let entity = HomeModuleEntity()
            entity.id = movie.id ?? 0
            entity.title = movie.title ?? ""
            entity.backdropPath = movie.backdropPath ?? ""
            entity.posterPath = movie.posterPath ?? ""
            entity.overview = movie.overview ?? ""
            entity.voteAverage = movie.voteAverage ?? 0.0
            entity.movieCategory = endpoint.rawValue
            entity.isFavorite = false
            return entity
        }
    }
    
    func transformEntitiesToDomains(from endpoint: MovieEndPoints, movies: [HomeModuleEntity]) -> [HomeDomainModel] {
        return movies.map { movie in
            return HomeDomainModel(
                id: movie.id,
                title: movie.title,
                backdropPath: movie.backdropPath ,
                posterPath: movie.posterPath,
                overview: movie.overview,
                voteAverage: movie.voteAverage,
                runtime: movie.runtime,
                movieCategory: endpoint.rawValue,
                releaseDate: movie.releaseDate,
                isFavorite: movie.isFavorite
            )
        }
    }
    
    public func transformResponseToEntity(response: MovieResponse) -> HomeModuleEntity {
        let movieEntity = HomeModuleEntity()
        movieEntity.id = response.id ?? 0
        movieEntity.title = response.title ?? ""
        movieEntity.backdropPath = response.backdropPath ?? ""
        movieEntity.posterPath = response.posterPath ?? ""
        movieEntity.runtime = response.runTime ?? 0
        movieEntity.overview = response.overview ?? ""
        movieEntity.voteAverage = response.voteAverage ?? 0
        movieEntity.releaseDate = response.releaseDate ?? ""
        movieEntity.isFavorite = false
        return movieEntity
    }
    
    public func transformEntityToDomain(entity: HomeModuleEntity) -> HomeDomainModel {
        return HomeDomainModel(
            id: entity.id,
            title: entity.title,
            backdropPath: entity.backdropPath ,
            posterPath: entity.posterPath,
            overview: entity.overview,
            voteAverage: entity.voteAverage,
            runtime: entity.runtime,
            movieCategory: entity.movieCategory,
            releaseDate: entity.releaseDate,
            isFavorite: entity.isFavorite
        )
    }

    public func tranformMovieEntitiesToDomains(endpoint: MovieEndPoints, entities: [HomeModuleEntity]) -> [HomeDomainModel] {
        return entities.map { movie in
            return HomeDomainModel(
                id: movie.id, title: movie.title,
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                overview: movie.overview,
                voteAverage: movie.voteAverage,
                runtime: movie.runtime,
                movieCategory: movie.movieCategory,
                releaseDate: movie.releaseDate,
                isFavorite: movie.isFavorite
            )
        }
    }
}

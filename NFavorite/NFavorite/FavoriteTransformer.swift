//
//  FavoriteTransformer.swift
//  NFavorite
//
//  Created by IT Division on 07/12/20.
//

import Foundation
import NCore

public struct FavoriteTransformer: Mapper {
    
    public typealias Response = Any
    public typealias Entity = MovieEntity
    public typealias Domain = FavoriteDomainModel

    public init() {}

    public func transformResponseToEntity(response: Any) -> MovieEntity {
        fatalError()
    }
    
    public func transformResponseToEntities(from endpoint: MovieEndPoints, list: [Any]) -> [MovieEntity] {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: MovieEntity) -> FavoriteDomainModel {
        return FavoriteDomainModel(
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

    public func tranformMovieEntitiesToDomains(endpoint: MovieEndPoints, entities: [MovieEntity]) -> [FavoriteDomainModel] {
        return entities.map { en in
            return FavoriteDomainModel(
                id: en.id,
                title: en.title,
                backdropPath: en.backdropPath,
                posterPath: en.posterPath,
                overview: en.overview,
                voteAverage: en.voteAverage,
                runtime: en.runtime,
                movieCategory: endpoint.rawValue,
                releaseDate: en.releaseDate,
                isFavorite: en.isFavorite
            )
        }
    }
}

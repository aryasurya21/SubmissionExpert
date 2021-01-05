//
//  DetailTransformer.swift
//  NDetail
//
//  Created by IT Division on 07/12/20.
//

import Foundation
import RealmSwift
import NCore

public struct DetailTransformer: Mapper {
    
    public typealias Response = MovieResponse
    public typealias Entity = DetailModuleEntity
    public typealias Domain = DetailDomainModel
    
    public init() {}
    
    public func transformResponseToEntity(response: MovieResponse) -> DetailModuleEntity {
        let movieEntity = DetailModuleEntity()
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
    
    public func transformEntityToDomain(entity: DetailModuleEntity) -> DetailDomainModel {
        return DetailDomainModel(
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
    
    public func tranformMovieEntitiesToDomains(endpoint: MovieEndPoints, entities: [DetailModuleEntity]) -> [DetailDomainModel] {
        return entities.map { movie in
            return DetailDomainModel(
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

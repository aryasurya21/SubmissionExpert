//
//  GetFavoritesRepository.swift
//  NFavorite
//
//  Created by IT Division on 07/12/20.
//

import Foundation
import NCore
import Combine

public struct GetFavoritesRepository<
    GetFavoritesLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository
where
    GetFavoritesLocaleDataSource.Response == FavoriteModuleEntity,
    Transformer.Response == Any,
    Transformer.Entity == FavoriteModuleEntity,
    Transformer.Domain == FavoriteDomainModel {

    public typealias Request = Any
    public typealias Response = [FavoriteDomainModel]

    private var localeDataSource: GetFavoritesLocaleDataSource
    private var mapper: Transformer

    public init(
        localeDataSource: GetFavoritesLocaleDataSource,
        mapper: Transformer
    ) {
        self.localeDataSource = localeDataSource
        self.mapper = mapper
    }

    public func execute(endpoint: MovieEndPoints, request: Any?) -> AnyPublisher<[FavoriteDomainModel], Error> {
            return self.localeDataSource.list(request: nil)
                .map { self.mapper.tranformMovieEntitiesToDomains(endpoint: endpoint, entities: $0) }
                .eraseToAnyPublisher()
    }

    public func toggle(movieID: Int) -> AnyPublisher<FavoriteDomainModel, Error> {
        return self.localeDataSource.toggle(id: movieID)
            .map { self.mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}

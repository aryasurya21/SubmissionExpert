//
//  GetHomeRepository.swift
//  NHome
//
//  Created by IT Division on 11/01/21.
//

import Foundation
import NCore
import Combine

public struct GetHomeRepository<
    GetHomeLocaleDataSource: LocaleDataSource,
    GetHomeRemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository
where
    GetHomeRemoteDataSource.Request == Any,
    GetHomeRemoteDataSource.Response == [MovieResponse],
    GetHomeLocaleDataSource.Response == MovieEntity,
    Transformer.Response == MovieResponse,
    Transformer.Entity == MovieEntity,
    Transformer.Domain == HomeDomainModel {
   
    public typealias Request = Any
    public typealias Response = [HomeDomainModel]

    private var localeDataSource: GetHomeLocalDataSource
    private var remoteSource: GetHomeRemoteDataSource
    private var mapper: HomeTransformer

    public init(
        localeDataSource: GetHomeLocalDataSource,
        remoteDataSource: GetHomeRemoteDataSource,
        mapper: HomeTransformer
    ) {
        self.localeDataSource = localeDataSource
        self.remoteSource = remoteDataSource
        self.mapper = mapper
    }

    public func execute(endpoint: MovieEndPoints, request: Any?) -> AnyPublisher<[HomeDomainModel], Error> {
        return self.localeDataSource.list(endpoint: endpoint)
            .flatMap { result -> AnyPublisher<[HomeDomainModel], Error> in
                
            if result.isEmpty {
                return self.remoteSource.execute(endpoint: endpoint, request: request ?? 0)
                    .map { mapper.transformResponseToEntities(from: endpoint, list: $0) }
                    .catch { _ in self.localeDataSource.list(endpoint: endpoint) }
                    .flatMap { self.localeDataSource.add(entities: $0) }
                    .filter { $0 }
                    .flatMap { _ in self.localeDataSource.list(endpoint: endpoint)
                        .map { mapper.transformEntitiesToDomains(from: endpoint, movies: $0) }
                    }.eraseToAnyPublisher()
            } else {
                return self.localeDataSource.list(endpoint: endpoint)
                    .map { mapper.tranformMovieEntitiesToDomains(endpoint: endpoint, entities: $0) }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
    
    public func toggle(request: Any?) -> AnyPublisher<[HomeDomainModel], Error> {
        fatalError()
    }
}

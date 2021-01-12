//
//  GetDetailRepository.swift
//  NDetail
//
//  Created by IT Division on 07/12/20.
//

import Foundation
import NCore
import Combine

public struct GetDetailRepository<
    GetDetailLocalDataSource: LocaleDataSource,
    GetDetailRemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    GetDetailRemoteDataSource.Request == Int,
    GetDetailLocalDataSource.Response == MovieEntity,
    GetDetailRemoteDataSource.Response == MovieResponse,
    Transformer.Response == MovieResponse,
    Transformer.Domain == DetailDomainModel,
    Transformer.Entity == MovieEntity {

    public typealias Request = Int
    public typealias Response = DetailDomainModel

    private let _localeDataSource: GetDetailLocalDataSource
    private let _remoteDataSource: GetDetailRemoteDataSource
    private let _mapper: DetailTransformer

    public init(
        localeDataSource: GetDetailLocalDataSource,
        remoteDataSource: GetDetailRemoteDataSource,
        mapper: DetailTransformer
    ) {
        self._localeDataSource = localeDataSource
        self._remoteDataSource = remoteDataSource
        self._mapper = mapper
    }

    public func toggle(request: Int?) -> AnyPublisher<DetailDomainModel, Error> {
        return self._localeDataSource.toggle(id: request ?? 0)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }

    public func execute(endpoint: MovieEndPoints, request: Int?) -> AnyPublisher<DetailDomainModel, Error> {
        return self._localeDataSource.get(id: request ?? 0)
            .flatMap { (result) -> AnyPublisher<DetailDomainModel, Error> in
                if result.runtime == 0 {
                    return self._remoteDataSource.execute(endpoint: endpoint, request: request ?? 0)
                        .map { self._mapper.transformResponseToEntity(response: $0) }
                        .catch { _ in self._localeDataSource.get(id: request ?? 0) }
                        .flatMap { self._localeDataSource.update(id: "\(request ?? 0)", entity: $0) }
                        .filter { $0 }
                        .flatMap { _ in self._localeDataSource.get(id: request ?? 0)
                            .map { self._mapper.transformEntityToDomain(entity: $0) } }
                        .eraseToAnyPublisher()
                } else {
                    return self._localeDataSource.get(id: request ?? 0)
                        .map { self._mapper.transformEntityToDomain(entity: $0) }
                      .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}

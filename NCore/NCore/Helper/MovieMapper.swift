//
//  MovieMapper.swift
//  NCore
//
//  Created by IT Division on 05/12/20.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain

    func transformResponseToEntity(response: Response) -> Entity
    func transformEntityToDomain(entity: Entity) -> Domain
    func tranformMovieEntitiesToDomains(endpoint: MovieEndPoints, entities: [Entity]) -> [Domain]
    func transformResponseToEntities(from endpoint: MovieEndPoints, list: [Response]) -> [Entity]
}

//
//  FavoriteInteractor.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import Foundation
import Combine

class FavoriteInteractor: FavoriteUseCaseProtocol {

    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
        return self.repository.getFavoriteMovies()
    }
}

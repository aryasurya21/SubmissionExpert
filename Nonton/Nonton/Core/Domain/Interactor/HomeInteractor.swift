//
//  HomeInteractor.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation
import Combine

class HomeInteractor: HomeUseCaseProtocol {

    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func getMovieList(from endpoint: MovieEndPoints) -> AnyPublisher<[MovieModel], Error> {
        self.repository.getMovieList(from: endpoint)
    }
}

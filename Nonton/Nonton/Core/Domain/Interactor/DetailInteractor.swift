//
//  DetailInteractor.swift
//  Nonton
//
//  Created by IT Division on 15/11/20.
//

import Foundation
import Combine

class DetailInteractor: DetailUseCaseProtocol {

    private let repository: MovieRepositoryProtocol
    private let movieID: Int

    init(repository: MovieRepositoryProtocol, withID movieID: Int) {
        self.repository = repository
        self.movieID = movieID
    }

    func getMovieDetail() -> AnyPublisher<MovieModel, Error> {
        return self.repository.getMovieDetail(withID: self.movieID)
    }

    func toggleFavoriteMovie() -> AnyPublisher<MovieModel, Error> {
        return self.repository.toggleFavoriteMovie(forID: self.movieID)
    }
}

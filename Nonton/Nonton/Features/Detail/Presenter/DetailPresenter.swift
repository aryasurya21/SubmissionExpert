//
//  DetailPresenter.swift
//  Nonton
//
//  Created by IT Division on 15/11/20.
//

import Foundation
import SwiftUI
import Combine

class DetailPresenter: ObservableObject {

    private let useCase: DetailUseCaseProtocol
    private var movieID: Int
    private var cancellables: Set<AnyCancellable> = []

    @Published var movieData: MovieModel?
    @Published var error: Error?
    @Published var isLoading = false

    init(useCase: DetailUseCaseProtocol, movieID: Int) {
        self.useCase = useCase
        self.movieID = movieID
    }

    func getMovieDetail() {
        self.isLoading = true
        self.useCase.getMovieDetail()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            self.error = error
            self.isLoading = false
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { movieData in
          self.movieData = movieData
        })
        .store(in: &cancellables)
    }

    func toggleFavoriteMovie() {
        self.isLoading = true
        self.useCase.toggleFavoriteMovie()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            self.error = error
            self.isLoading = false
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { movieData in
          self.movieData = movieData
        })
        .store(in: &cancellables)
    }
}

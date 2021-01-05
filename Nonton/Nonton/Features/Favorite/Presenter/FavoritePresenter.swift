//
//  FavoritePresenter.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import Foundation
import Combine
import SwiftUI

class FavoritePresenter: ObservableObject {

    private let useCase: FavoriteUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()

    @Published var movies: [MovieModel]?
    @Published var error: Error?
    @Published var isLoading = false

    init(useCase: FavoriteUseCaseProtocol) {
        self.useCase = useCase
    }

    func getFavoriteMovies() {
        self.isLoading = true
        self.useCase.getFavoriteMovies()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            self.error = error
            self.isLoading = false
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { movies in
          self.movies = movies
        })
        .store(in: &cancellables)
    }

    func viewBuilder<Content: View>(movieData: MovieModel, @ViewBuilder content: () -> Content) -> some View {
        return NavigationLink(destination: router.goToDetailView(for: movieData)) {
            content()
        }
    }
}

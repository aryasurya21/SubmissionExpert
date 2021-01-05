//
//  HomePresenter.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation
import Combine
import SwiftUI

class HomePresenter: ObservableObject {

    private let useCase: HomeUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    @Published var upcomingMovies: [MovieModel]?
    @Published var nowPlayingMovies: [MovieModel]?
    @Published var topRatedMovies: [MovieModel]?
    @Published var popularMovies: [MovieModel]?
    @Published var isLoading = false
    @Published var error: Error?

    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }

    func getMovies(for endpoint: MovieEndPoints) {
        self.resetMovieList()
        self.isLoading = true
        self.useCase.getMovieList(from: endpoint)
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    self.error = error
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            } receiveValue: { (movies) in
                switch endpoint {
                case .nowPlaying:
                    self.nowPlayingMovies =  movies
                case .popular:
                    self.popularMovies = movies
                case .topRated:
                    self.topRatedMovies = movies
                case .upcoming:
                    self.upcomingMovies = movies
                }
            }.store(in: &self.cancellables)
    }

    private func resetMovieList() {
        self.nowPlayingMovies =  nil
        self.popularMovies = nil
        self.topRatedMovies = nil
        self.upcomingMovies = nil
    }

    func viewBuilder<Content: View>(movieData: MovieModel, @ViewBuilder content: () -> Content) -> some View {
        return NavigationLink(destination: router.goToDetailView(for: movieData)) {
            content()
        }
    }
}

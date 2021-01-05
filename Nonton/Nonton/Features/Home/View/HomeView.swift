//
//  HomeView.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter

    var body: some View {
        NavigationView {
            if self.presenter.error != nil {
                ErrorView(errorMessage: self.presenter.error?.localizedDescription ?? "")
            } else if self.presenter.isLoading {
                ActivityIndicator()
            } else {
                List {
                    Group {
                        if self.presenter.nowPlayingMovies != nil {
                            MoviePosterList(
                                movies: self.presenter.nowPlayingMovies!,
                                title: "Now Playing",
                                presenter: self.presenter
                            )
                        }
                    }.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    Group {
                        if self.presenter.upcomingMovies != nil {
                            MovieBackdropList(
                                title: "Upcoming",
                                movies: self.presenter.upcomingMovies!,
                                presenter: self.presenter
                            )
                        }
                    }.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    Group {
                        if self.presenter.topRatedMovies != nil {
                            MovieBackdropList(
                                title: "Top Rated",
                                movies: self.presenter.topRatedMovies!,
                                presenter: self.presenter
                            )
                        }
                    }.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    Group {
                        if self.presenter.popularMovies != nil {
                            MoviePosterList(
                                movies: self.presenter.popularMovies!,
                                title: "Popular",
                                presenter: self.presenter
                            )
                        }
                    }.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                }.navigationBarTitle("Nonton Yuk!")
            }
        }.onAppear(perform: {
            if self.presenter.nowPlayingMovies == nil {
            self.presenter.getMovies(for: .nowPlaying)
            }
            if self.presenter.popularMovies == nil {
            self.presenter.getMovies(for: .popular)
            }
            if self.presenter.topRatedMovies == nil {
            self.presenter.getMovies(for: .topRated)
            }
            if self.presenter.upcomingMovies == nil {
            self.presenter.getMovies(for: .upcoming)
            }
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(presenter: HomePresenter(useCase: Injector.shared.injectHomeInteractor()))
    }
}

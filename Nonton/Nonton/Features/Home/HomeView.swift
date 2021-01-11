//
//  HomeView.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation
import SwiftUI
import NCore
import NHome

struct HomeView: View {
    @ObservedObject var presenter: GetListPresenter<
        Any,
        HomeDomainModel,
        Interactor<
            Any, [HomeDomainModel], GetHomeRepository<
                GetHomeLocalDataSource, GetHomeRemoteDataSource, HomeTransformer
            >>>

    var body: some View {
        NavigationView {
            if self.presenter.isError {
                ErrorView(errorMessage: self.presenter.errorMessage)
            } else if self.presenter.isLoading {
                ActivityIndicator()
            } else {
                List {
                    Group {
                        if self.presenter.nowPlaying.count > 0 {
                            MoviePosterList(
                                movies: self.presenter.nowPlaying,
                                title: "Now Playing",
                                presenter: self.presenter
                            )
                        }
                    }.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    Group {
                        if self.presenter.upcoming.count > 0 {
                            MovieBackdropList(
                                title: "Upcoming",
                                movies: self.presenter.upcoming,
                                presenter: self.presenter
                            )
                        }
                    }.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    Group {
                        if self.presenter.topRated.count > 0 {
                            MovieBackdropList(
                                title: "Top Rated",
                                movies: self.presenter.topRated,
                                presenter: self.presenter
                            )
                        }
                    }.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    Group {
                        if self.presenter.popular.count > 0 {
                            MoviePosterList(
                                movies: self.presenter.popular,
                                title: "Popular",
                                presenter: self.presenter
                            )
                        }
                    }.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                }.navigationBarTitle("Nonton Yuk!")
            }
        }.onAppear(perform: {
            if self.presenter.nowPlaying.count == 0 {
                self.presenter.getList(endpoint: .nowPlaying, request: nil)
            }
            if self.presenter.topRated.count == 0 {
                self.presenter.getList(endpoint: .topRated, request: nil)
            }
            if self.presenter.upcoming.count == 0 {
                self.presenter.getList(endpoint: .upcoming, request: nil)
            }
            if self.presenter.popular.count == 0 {
                self.presenter.getList(endpoint: .popular, request: nil)
            }
        })
    }
}

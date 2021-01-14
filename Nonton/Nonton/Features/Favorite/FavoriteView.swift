//
//  FavoriteView.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import SwiftUI
import NCore
import NFavorite

struct FavoriteView: View {
    @ObservedObject var presenter: GetListPresenter<Any, FavoriteDomainModel,
        Interactor<Any, [FavoriteDomainModel],
            GetFavoritesRepository<
            GetFavoritesLocaleDataSource,
            FavoriteTransformer
        >>,
        FavoriteRouter>

    var body: some View {
        NavigationView {
            ZStack {
                if self.presenter.isError {
                    ErrorView(errorMessage: self.presenter.errorMessage)
                } else if self.presenter.isLoading {
                    ActivityIndicator()
                } else if self.presenter.list.count > 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.presenter.list) { movie in
                            ZStack {
                                self.presenter.viewBuilder(data: movie) {
                                    MovieRow(movie: movie)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }.navigationBarTitle("Favorite Movies", displayMode: .large)
                } else {
                    Text("No Favorite Movies Yet. Try Adding Some First!")
                        .font(.headline).navigationBarTitle("Favorite Movies", displayMode: .large)
                }
            }.onAppear {
                self.presenter.getList(endpoint: nil, request: nil)
            }.navigationBarTitle("Favorite Movies")
        }

    }
}

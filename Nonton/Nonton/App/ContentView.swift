//
//  ContentView.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import SwiftUI
import NCore
import NFavorite
import NHome

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<
        Any,
        HomeDomainModel,
        Interactor<
            Any, [HomeDomainModel], GetHomeRepository<
                GetHomeLocalDataSource, GetHomeRemoteDataSource, HomeTransformer
            >>,
        HomeRouter>
    @EnvironmentObject var favoritePresenter: GetListPresenter<
        Any,
        FavoriteDomainModel,
        Interactor<
            Any, [FavoriteDomainModel], GetFavoritesRepository<
                GetFavoritesLocaleDataSource, FavoriteTransformer
            >>,
        FavoriteRouter>

    var body: some View {
        TabView {
            HomeView(presenter: self.homePresenter)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }.tag(0)
            FavoriteView(presenter: self.favoritePresenter)
                .tabItem {
                    VStack {
                        Image(systemName: "heart.fill")
                        Text("Favorite")
                    }
                }.tag(1)
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

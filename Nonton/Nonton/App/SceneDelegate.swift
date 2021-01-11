//
//  SceneDelegate.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import UIKit
import SwiftUI
import NFavorite
import NCore
import NHome

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let homeInteractor: Interactor<Any, [HomeDomainModel], GetHomeRepository<
            GetHomeLocalDataSource,
            GetHomeRemoteDataSource,
            HomeTransformer
        >> = Injector.shared.provideHome()
        
        let favoriteInteractor: Interactor<Any, [FavoriteDomainModel], GetFavoritesRepository<
            GetFavoritesLocaleDataSource,
            FavoriteTransformer
        >> = Injector.shared.provideFavorite()
        
        let homePresenter = GetListPresenter(useCase: homeInteractor)
        let favoritePresenter = GetListPresenter(useCase: favoriteInteractor)

        let contentView = ContentView()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        let docDirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).map(\.path)[0]
        print("\(docDirPath)")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

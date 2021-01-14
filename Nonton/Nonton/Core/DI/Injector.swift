//
//  Injector.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation
import RealmSwift
import NCore
import NFavorite
import NDetail
import NHome

final class Injector {

    static let shared = Injector()
    private init() { }

    func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [FavoriteDomainModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locale = GetFavoritesLocaleDataSource(appDelegate.realm)
        let mapper = FavoriteTransformer()
        let repository = GetFavoritesRepository(localeDataSource: locale, mapper: mapper)
        return Interactor(repository) as! U
    }

    func provideDetail<U: UseCase>(id: Int) -> U where U.Request == Int, U.Response == DetailDomainModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locale = GetDetailLocalDataSource(realm: appDelegate.realm)
        let remote = GetDetailRemoteDataSource(movieID: id)
        let mapper = DetailTransformer()
        let repository = GetDetailRepository<
            GetDetailLocalDataSource,
            GetDetailRemoteDataSource, DetailTransformer>(
            localeDataSource: locale,
            remoteDataSource: remote, mapper: mapper)
        return Interactor(repository) as! U
    }

    func provideHome<U: UseCase>() -> U where U.Request == Any, U.Response == [HomeDomainModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locale = GetHomeLocalDataSource(realm: appDelegate.realm)
        let remote = GetHomeRemoteDataSource()
        let mapper = HomeTransformer()
        let repository = GetHomeRepository<
            GetHomeLocalDataSource,
            GetHomeRemoteDataSource,
            HomeTransformer>(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        return Interactor(repository) as! U
    }
}

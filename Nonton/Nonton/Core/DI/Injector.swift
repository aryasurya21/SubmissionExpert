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
    
    private func injectRepository() -> MovieRepositoryProtocol {
        let realm = try? Realm()

        let local = LocalInstance.shared(realm)
        let api = APIInstance.shared

        return MovieRepository.shared(api, local)
    }

    public func injectHomeInteractor() -> HomeUseCaseProtocol {
        return HomeInteractor(repository: self.injectRepository())
    }

    public func injectDetailInteractor(movieID: Int) -> DetailUseCaseProtocol {
        return DetailInteractor(repository: self.injectRepository(), withID: movieID)
    }

    public func injectFavoriteInteractor() -> FavoriteUseCaseProtocol {
        return FavoriteInteractor(repository: self.injectRepository())
    }
}

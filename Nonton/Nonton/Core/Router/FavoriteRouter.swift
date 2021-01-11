//
//  FavoriteRouter.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import Foundation
import SwiftUI
import NDetail
import NCore
import NHome
import NFavorite

class FavoriteRouter {
    func goToDetailView(for movie: FavoriteDomainModel) -> some View {
        let detailInteractor: Interactor<
            Int,
            DetailDomainModel,
            GetDetailRepository<
                GetDetailLocalDataSource,
                GetDetailRemoteDataSource,
                DetailTransformer
            >> = Injector.shared.provideDetail(id: movie.id)
        let detailPresenter = GetSinglePresenter(useCase: detailInteractor, movieID: movie.id)
        return DetailView(presenter: detailPresenter)
    }
}

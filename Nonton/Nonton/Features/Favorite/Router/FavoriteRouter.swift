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

class FavoriteRouter {
    func goToDetailView(for movie: MovieModel) -> some View {
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

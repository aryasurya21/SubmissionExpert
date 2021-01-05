//
//  FavoriteRouter.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import Foundation
import SwiftUI

class FavoriteRouter {
    func goToDetailView(for movie: MovieModel) -> some View {
        let detailUseCase = Injector.shared.injectDetailInteractor(movieID: movie.id)
        let detailPresenter = DetailPresenter(useCase: detailUseCase, movieID: movie.id)
        return DetailView(presenter: detailPresenter)
    }
}

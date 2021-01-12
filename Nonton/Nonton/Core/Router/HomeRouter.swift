//
//  HomeRouter.swift
//  Nonton
//
//  Created by IT Division on 15/11/20.
//

import Foundation
import SwiftUI
import NCore
import NDetail
import NFavorite
import NHome

public class HomeRouter: Router {

    public typealias Request = Any
    public typealias Destination = DetailView

    public func navigate(with request: Any?) -> DetailView {
        guard let request = request as? HomeDomainModel else { fatalError() }
        let detailInteractor: Interactor<Int, DetailDomainModel, GetDetailRepository<
            GetDetailLocalDataSource,
            GetDetailRemoteDataSource,
            DetailTransformer>>
            = Injector.shared.provideDetail(id: request.id)
        let detailPresenter = GetSinglePresenter(useCase: detailInteractor, movieID: request.id)
        return DetailView(presenter: detailPresenter)
    }
}

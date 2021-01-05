//
//  FavoriteUseCase.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import Foundation
import Combine

protocol FavoriteUseCaseProtocol {
    func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
}

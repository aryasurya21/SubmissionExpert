//
//  HomeUseCase.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation
import Combine

protocol HomeUseCaseProtocol {
    func getMovieList(from endpoint: MovieEndPoints) -> AnyPublisher<[MovieModel], Error>
}

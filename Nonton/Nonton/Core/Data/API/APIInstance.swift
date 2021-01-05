//
//  APIInstance.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation
import Combine
import Alamofire
import NCore

protocol APICapabilityProtocol {
    func getMovieList(from endpoint: MovieEndPoints) -> AnyPublisher<[MovieResponse], Error>
    func getMovieDetail(withID movieID: Int) -> AnyPublisher<MovieResponse, Error>
}

class APIInstance {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "913b4714c3644e3442541d832c16e6fe"

    static let shared = APIInstance()
    private init() {}
}

extension APIInstance: APICapabilityProtocol {
    func getMovieDetail(withID movieID: Int) -> AnyPublisher<MovieResponse, Error> {
        let parameters: Parameters = [
            "api_key": apiKey
        ]
        return Future<MovieResponse, Error> { (completion) in
            if let url = URL(string: "\(self.baseURL)/movie/\(movieID)") {
                AF.request(url, method: .get, parameters: parameters)
                    .validate().responseDecodable(of: MovieResponse.self) { (response) in
                        switch response.result {
                        case .success(let movie):
                            completion(.success(movie))
                        case .failure:
                            completion(.failure(MovieError.apiError))
                        }
                    }
            } else {
                completion(.failure(MovieError.invalidEndpoint))
            }
        }.eraseToAnyPublisher()
    }

    func getMovieList(from endpoint: MovieEndPoints) -> AnyPublisher<[MovieResponse], Error> {
        let parameters: Parameters = [
            "api_key": apiKey
        ]
        return Future<[MovieResponse], Error> { (completion) in
            if let url = URL(string: "\(self.baseURL)/movie/\(endpoint.rawValue)") {
                AF.request(url, method: .get, parameters: parameters)
                    .validate()
                    .responseDecodable(of: MovieResponseWrapper.self) { (response) in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data.results))
                    case .failure:
                        completion(.failure(MovieError.apiError))
                    }
                }
            } else {
                return completion(.failure(MovieError.invalidEndpoint))
            }
        }.eraseToAnyPublisher()
    }
}

//
//  GetDetailRemoteDataSource.swift
//  NDetail
//
//  Created by IT Division on 07/12/20.
//

import Foundation
import NCore
import Combine
import Alamofire

public struct GetDetailRemoteDataSource: DataSource {
  
    public typealias Request = Int
    public typealias Response = MovieResponse

    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "913b4714c3644e3442541d832c16e6fe"

    private let movieID: Int

    public init(movieID: Int) {
        self.movieID = movieID
    }

    public func execute(endpoint: MovieEndPoints, request: Int?) -> AnyPublisher<MovieResponse, Error> {
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
}

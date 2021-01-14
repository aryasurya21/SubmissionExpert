//
//  GetListPresenter.swift
//  NCore
//
//  Created by IT Division on 05/12/20.
//

import Foundation
import SwiftUI
import Combine

public class GetSinglePresenter<
    Request,
    Response,
    Interactor: UseCase
>: ObservableObject
where
    Interactor.Request == Request,
    Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []

    private let _useCase: Interactor
    private let _movieID: Request
    @Published public var data: Response?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false

    public init(useCase: Interactor, movieID: Request) {
        self._useCase = useCase
        self._movieID = movieID
    }

    public func getData() {
        isLoading = true
        _useCase.execute(endpoint: .nowPlaying, request: self._movieID)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { data in
                self.data = data
            })
            .store(in: &cancellables)
    }

    public func toggleFavoriteMovie() {
        self.isLoading = true
        self._useCase.toggle(request: self._movieID)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.isError = true
            self.isLoading = false
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { movieData in
          self.data = movieData
        })
        .store(in: &cancellables)
    }

    public func viewBuilder<Content: View, Router>(data: Response, @ViewBuilder content: () -> Content) -> some View {
        
        return content()
    }
}

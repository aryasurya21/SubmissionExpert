//
//  GetListPresenter.swift
//  NCore
//
//  Created by IT Division on 05/12/20.
//

import Foundation
import SwiftUI
import Combine

public class GetListPresenter<
    Request,
    Response,
    Interactor: UseCase
>: ObservableObject
where
    Interactor.Request == Request,
    Interactor.Response == [Response] {

    private var cancellables: Set<AnyCancellable> = []

    private let _useCase: Interactor

    @Published public var list: [Response] = []
    
    @Published public var upcoming: [Response] = []
    @Published public var topRated: [Response] = []
    @Published public var popular: [Response] = []
    @Published public var nowPlaying: [Response] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false

    public init(useCase: Interactor) {
        _useCase = useCase
    }

    public func getList(endpoint: MovieEndPoints, request: Request?) {
        isLoading = true
        _useCase.execute(endpoint: endpoint, request: request)
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
            }, receiveValue: { list in
                switch endpoint {
                case .nowPlaying:
                    self.nowPlaying = list
                case .popular:
                    self.popular = list
                case .topRated:
                    self.topRated = list
                case .upcoming:
                    self.upcoming = list
                }
            })
            .store(in: &cancellables)
    }

    public func viewBuilder<Content: View>(data: Response, @ViewBuilder content: () -> Content) -> some View {
        return content()
    }
}

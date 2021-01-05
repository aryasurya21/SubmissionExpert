//
//  MoviePosterList.swift
//  Nonton
//
//  Created by IT Division on 14/11/20.
//

import SwiftUI

struct MoviePosterList: View {
    let movies: [MovieModel]
    let title: String
    let presenter: HomePresenter

    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text(self.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(alignment: .top, spacing: 20.0) {
                    ForEach(self.movies) { movie in
                        self.presenter.viewBuilder(movieData: movie) {
                            MoviePoster(movie: movie)
                                .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            })
        }
    }
}

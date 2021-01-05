//
//  MovieBackdropList.swift
//  Nonton
//
//  Created by IT Division on 15/11/20.
//

import Foundation
import SwiftUI

struct MovieBackdropList: View {
    let title: String
    let movies: [MovieModel]
    let presenter: HomePresenter

    var body: some View {
        VStack(alignment: .leading) {
           Text(self.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
           ScrollView(.horizontal, showsIndicators: false) {
               HStack(alignment: .top, spacing: 16) {
                   ForEach(self.movies) { movie in
                        self.presenter.viewBuilder(movieData: movie) {
                           MovieBackdrop(movie: movie)
                        }
                        .frame(width: 250, height: 190)
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                   }
               }
           }
       }
    }
}

//
//  MoviePoster.swift
//  Nonton
//
//  Created by IT Division on 14/11/20.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct MoviePoster: View {
    let movie: MovieModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            WebImage(url: movie.posterImageURL)
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .cornerRadius(8)
                .shadow(radius: 5)
                .frame(width: 170, height: 250, alignment: .center)
            Text(movie.title.count > 20 ? String(movie.title.prefix(18))+"..." : movie.title)
                .foregroundColor(Color.black)
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
}

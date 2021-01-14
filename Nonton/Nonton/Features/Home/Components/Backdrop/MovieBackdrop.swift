//
//  MovieCard.swift
//  Nonton
//
//  Created by IT Division on 14/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import NHome

struct MovieBackdrop: View {
    var movie: HomeDomainModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            WebImage(url: movie.backdropURL)
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .aspectRatio(16/9, contentMode: .fit)
                .cornerRadius(8)
                .shadow(radius: 4)
            Text(movie.title.count > 30 ? String(movie.title.prefix(28))+"..." : movie.title)
                .font(.subheadline)
                .fontWeight(.bold)
                .lineLimit(1)
        }
    }
}

//
//  MovieRow.swift
//  Nonton
//
//  Created by IT Division on 16/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import NFavorite

struct MovieRow: View {
    var movie: FavoriteDomainModel
    
    var body: some View {
        VStack {
            WebImage(url: movie.backdropURL)
                .resizable()
                .indicator(.activity)
                .aspectRatio(16/9, contentMode: .fit)
            HStack(alignment: .top) {
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Text(movie.formattedRating)
                    .font(.title)
                    .fontWeight(.bold)
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            }.padding([.leading, .trailing], 10)
        }.cornerRadius(6)
        .shadow(radius: 10)
        .padding()
    }
}

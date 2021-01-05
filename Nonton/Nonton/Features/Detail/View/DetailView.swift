//
//  DetailView.swift
//  Nonton
//
//  Created by IT Division on 15/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    @State private var showPopup = false

    var body: some View {
        ScrollView {
            if self.presenter.isLoading {
                ActivityIndicator()
            } else {
                VStack {
                    WebImage(url: self.presenter.movieData?.backdropURL)
                        .resizable()
                        .indicator(.activity)
                        .aspectRatio(16/9, contentMode: .fit)
                    HStack {
                        Text(self.presenter.movieData?.title ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        if let movie = self.presenter.movieData, movie.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.red)
                                .padding()
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 1)
                                ).onTapGesture {
                                    self.presenter.toggleFavoriteMovie()
                                    self.showPopup = true
                                }
                        } else {
                        Image(systemName: "heart")
                            .padding()
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                            ).onTapGesture {
                                self.presenter.toggleFavoriteMovie()
                                self.showPopup = true
                            }
                        }
                    }.padding()
                    Text(self.presenter.movieData?.overview ?? "")
                        .font(.body)
                        .padding()
                    Divider()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Release Date")
                                .font(.title)
                                .fontWeight(.bold)
                            Text(self.presenter.movieData?.formattedReleaseDate ?? "To be announced.")
                        }
                        Spacer()
                    }.padding()
                    Divider()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Duration")
                                .font(.title)
                                .fontWeight(.bold)
                            Text(self.presenter.movieData?.formattedDuration ?? "-")
                        }
                        Spacer()
                    }.padding()
                    Divider()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Rating")
                                .font(.title)
                                .fontWeight(.bold)
                            HStack {
                                Text("\(self.presenter.movieData?.formattedRating ?? "")")
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                            }
                        }
                        Spacer()
                    }.padding()
                    Spacer()
                }
            }
        }.navigationBarTitle(self.presenter.movieData?.title ?? "Movie Detail", displayMode: .inline)
        .onAppear {
            self.presenter.getMovieDetail()
        }.alert(isPresented: $showPopup, content: {
            Alert(
              title: Text("Success!"),
                message: Text(
                    """
                    Succesfully
                    \(presenter.movieData?.isFavorite ?? false ? "favorited" : "unfavorited")
                    this movie!
                    """
                ),
              dismissButton: .default(Text("OK"))
            )
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(presenter: DetailPresenter(useCase: Injector.shared.injectDetailInteractor(movieID: 1), movieID: 1))
    }
}

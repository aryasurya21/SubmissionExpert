//
//  DetailView.swift
//  Nonton
//
//  Created by IT Division on 15/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import NCore
import NDetail

struct DetailView: View {
    @ObservedObject var presenter: GetSinglePresenter<Int, DetailDomainModel,
        Interactor<Int, DetailDomainModel,
            GetDetailRepository<
            GetDetailLocalDataSource,
            GetDetailRemoteDataSource,
            DetailTransformer
            >
        >>

    @State private var showPopup = false

    var body: some View {
        ScrollView {
            if self.presenter.isLoading {
                ActivityIndicator()
            } else {
                VStack {
                    WebImage(url: self.presenter.data?.backdropURL ?? URL(string: ""))
                        .resizable()
                        .indicator(.activity)
                        .aspectRatio(16/9, contentMode: .fit)
                HStack {
                    Text(self.presenter.data?.title ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    if self.presenter.data?.isFavorite ?? false {
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
                Text(self.presenter.data?.overview ?? "")
                    .font(.body)
                    .padding()
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Release Date")
                            .font(.title)
                            .fontWeight(.bold)
                        Text(self.presenter.data?.formattedReleaseDate ?? "To be announced.")
                    }
                    Spacer()
                }.padding()
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Duration")
                            .font(.title)
                            .fontWeight(.bold)
                        Text(self.presenter.data?.formattedDuration ?? "-")
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
                            Text("\(self.presenter.data?.formattedRating ?? "")")
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        }
                    }
                    Spacer()
                }.padding()
                Spacer()
            }
        }
    }.navigationBarTitle(self.presenter.data?.title ?? "Movie Detail", displayMode: .inline)
    .onAppear {
        self.presenter.getData()
    }.alert(isPresented: $showPopup, content: {
        Alert(
          title: Text("Success!"),
            message: Text(
                """
                Succesfully
                \(presenter.data?.isFavorite ?? false ? "favorited" : "unfavorited")
                this movie!
                """
            ),
          dismissButton: .default(Text("OK"))
        )
    })
        }

}

//
//  MovieModel.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation

struct MovieModel: Equatable, Identifiable {
    let id: Int
    let title: String
    let backdropPath: String
    let posterPath: String
    let overview: String
    let voteAverage: Double
    let runtime: Int
    let movieCategory: String
    let releaseDate: String
    let isFavorite: Bool

    var posterImageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(self.posterPath)")!
    }

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(self.backdropPath)")!
    }

    var formattedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.formatterBehavior = .default
        formatter.dateFormat = "yyyy-MM-dd"

        let date = formatter.date(from: releaseDate)

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MMMM d, YYYY"
        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputDateFormatter.formatterBehavior = .default
        return outputDateFormatter.string(from: date ?? Date())
    }

    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]

        let duration = formatter.string(from: TimeInterval(runtime) * 60)
        return duration ?? "\(runtime) minutes"
    }

    var formattedRating: String {
        return "\(self.voteAverage.rounded())"
    }
}

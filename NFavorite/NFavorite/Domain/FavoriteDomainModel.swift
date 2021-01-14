//
//  FavoriteDomainModel.swift
//  NFavorite
//
//  Created by IT Division on 07/12/20.
//

import Foundation

public struct FavoriteDomainModel: Equatable, Identifiable {
    public let id: Int
    public let title: String
    public let backdropPath: String
    public let posterPath: String
    public let overview: String
    public let voteAverage: Double
    public let runtime: Int
    public let movieCategory: String
    public let releaseDate: String
    public let isFavorite: Bool

    public var posterImageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(self.posterPath)")!
    }

    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(self.backdropPath)")!
    }

    public var formattedReleaseDate: String {
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

    public var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]

        let duration = formatter.string(from: TimeInterval(runtime) * 60)
        return duration ?? "\(runtime) minutes"
    }

    public var formattedRating: String {
        return "\(self.voteAverage.rounded())"
    }
}

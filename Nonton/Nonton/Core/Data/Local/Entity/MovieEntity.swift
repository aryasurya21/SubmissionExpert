//
//  MovieEntity.swift
//  Nonton
//
//  Created by IT Division on 13/11/20.
//

import Foundation
import RealmSwift

class MovieEntity: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var runtime: Int = 0
    @objc dynamic var movieCategory: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var isFavorite: Bool = false
}

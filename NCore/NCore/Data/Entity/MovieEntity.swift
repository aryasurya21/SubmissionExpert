//
//  MovieEntity.swift
//  NCore
//
//  Created by IT Division on 12/01/21.
//

import Foundation
import RealmSwift

public class MovieEntity: Object {

    @objc public dynamic var id: Int = 0
    @objc public dynamic var title: String = ""
    @objc public dynamic var backdropPath: String = ""
    @objc public dynamic var posterPath: String = ""
    @objc public dynamic var overview: String = ""
    @objc public dynamic var voteAverage: Double = 0.0
    @objc public dynamic var runtime: Int = 0
    @objc public dynamic var movieCategory: String = ""
    @objc public dynamic var releaseDate: String = ""
    @objc public dynamic var isFavorite: Bool = false
}

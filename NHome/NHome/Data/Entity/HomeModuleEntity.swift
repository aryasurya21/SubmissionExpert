//
//  HomeModuleEntity.swift
//  NHome
//
//  Created by IT Division on 11/01/21.
//

import Foundation
import RealmSwift

public class HomeModuleEntity: Object {

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

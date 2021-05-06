//
//  Movie.swift
//  Dogomania
//
//  Created by SWAN mac on 06.05.2021.
//

import Foundation

struct Welcome: Codable {
    let search: [Search]
    init() {
        search = [Search]()
    }
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Search: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case empty = ""
    case movie = "movie"
    case test = "test"
}


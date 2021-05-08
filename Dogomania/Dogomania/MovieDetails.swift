//
//  MovieDetails.swift
//  Dogomania
//
//  Created by SWAN mac on 07.05.2021.
//

import Foundation
struct MovieDetails: Codable {
    let title, year, rated, released: String
    let runtime, genre, director, writer: String
    let actors, plot, language, country: String
    let awards, poster, imdbRating, imdbVotes: String
    let imdbID, type, production: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case production = "Production"
    }
}

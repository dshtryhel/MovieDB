//
//  TVSerieData.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

// MARK: - TVSerieResult
struct TVSerieResult: Codable {
    let originalName: String?
    let genreids: [Int]?
    let name: String?
    let popularity: Double?
    let originCountry: [String]?
    let voteCount: Int?
    let firstAirDate, backdropPath: String?
    let originalLanguage: String?
    let id: Int?
    let voteAverage: Double?
    let overview, posterPath: String?

    private enum CodingKeys: String, CodingKey {
        case popularity, name, id, overview
        case originalName = "original_name"
        case genreids = "genre_ids"
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }

}


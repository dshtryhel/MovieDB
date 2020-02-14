//
//  TopRatedMovieData.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

// MARK: - MovieResult
struct MovieResult: Codable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath, originalLanguage, originalTitle: String?
    let genreids: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?

    private enum CodingKeys: String, CodingKey {
        case popularity, adult, id, video, title, overview
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreids = "genre_ids"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }

}

//
//  GenreResponse.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

// MARK: - GenreResponse
struct GenreResponse: Codable {
    let genres: [GenreData]?

    private enum CodingKeys: String, CodingKey {
        case genres
    }
    
}

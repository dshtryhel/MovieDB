//
//  GenreData.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

// MARK: - MovieGenreData
struct GenreData: Codable {
    let id: Int?
    let name: String?

    private enum CodingKeys: String, CodingKey {
        case id, name
    }
    
}

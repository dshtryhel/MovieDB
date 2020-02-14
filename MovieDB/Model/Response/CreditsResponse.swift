//
//  MovieCreditResponse.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

// MARK: - CreditsResponse
struct CreditsResponse: Codable {
    let cast: [CastData]?
    let crew: [CrewData]?
    let id: Int?

    private enum CodingKeys: String, CodingKey {
        case cast, crew, id
    }
    
}

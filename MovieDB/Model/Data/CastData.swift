//
//  CastData.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

// MARK: - CastData
struct CastData: Codable {
    let character, creditid: String?
    let id: Int?
    let name: String?
    let gender: Int?
    let profilePath: String?
    let order: Int?

    private enum CodingKeys: String, CodingKey {
        case character, id, name, order, gender
        case profilePath = "profile_path"
        case creditid = "credit_id"
    }
    
}

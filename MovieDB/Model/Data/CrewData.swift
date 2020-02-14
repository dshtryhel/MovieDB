//
//  CrewData.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

// MARK: - CrewData
struct CrewData: Codable {
    let creditid: String?
    let department: String?
    let id: Int?
    let name: String?
    let gender: Int?
    let job: String?
    let profilePath: String?

    private enum CodingKeys: String, CodingKey {
        case department, id, name, gender, job
         case profilePath = "profile_path"
         case creditid = "credit_id"
    }

}

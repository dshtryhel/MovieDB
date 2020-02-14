//
//  TVSerieResponse.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

// MARK: - TVSerieResponse
struct TVSerieResponse: Codable {
    
    let page, totalResults, totalPages: Int?
    let results: [TVSerieResult]?
    
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
}


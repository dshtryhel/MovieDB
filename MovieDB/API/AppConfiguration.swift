//
//  AppConfiguration.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Foundation

class AppConfiguration {
    static var apiKey: String {
        get {
            return "8b0f3b3d203ed2dd5e3ff1349dd9489f"
        }
    }
        
    static var host: String {
        get {
            return "api.themoviedb.org"
        }
    }
    
    static var apiVersion: String {
        get {
            return "3"
        }
    }
    
    static var language: String {
        get {
            return "en-US"
        }
    }
}

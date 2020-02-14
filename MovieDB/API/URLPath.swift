//
//  URLPaths.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Foundation

struct URLPath {
    // MARK: Movie URLs
    static let topRatedMovies = "/\(AppConfiguration.apiVersion)/movie/top_rated"
    static let nowPlayingMovies = "/\(AppConfiguration.apiVersion)/movie/now_playing"
    static let popularMovies = "/\(AppConfiguration.apiVersion)/movie/popular"

    // MARK: TV Serie URLs
    static let topRatedTVSeries = "/\(AppConfiguration.apiVersion)/tv/top_rated"
    static let popularTVSeries = "/\(AppConfiguration.apiVersion)/tv/popular"

    // MARK: Movie and TV Serie Genre URL
    static let movieGenres = "/\(AppConfiguration.apiVersion)/genre/movie/list"
    static let tvSerieGenres = "/\(AppConfiguration.apiVersion)/genre/tv/list"
    
    // MARK: Movie and TV Serie Search URL
    static let movieSearch = "/\(AppConfiguration.apiVersion)/search/movie"
    static let tvSerieSearch  = "/\(AppConfiguration.apiVersion)/search/tv"
}

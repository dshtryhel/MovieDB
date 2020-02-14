//
//  AlamofireService.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Alamofire

class AlamofireService {
    
    static var urlScheme: String {
        get {
            return "https"
        }
    }
    
    static func getMovies(page: Int, path: String, query: String?, completion: @escaping (AFDataResponse<MovieResponse>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = AppConfiguration.host
        urlComponents.path = path
        urlComponents.scheme = urlScheme
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: AppConfiguration.apiKey),
            URLQueryItem(name: "language", value: AppConfiguration.language),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        if let query = query, !query.isEmpty {
            urlComponents.queryItems?.append(
                URLQueryItem(name: "query", value: query)
            )
        }
        
        AF.request(urlComponents.string!, method: .get, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseDecodable { (response: AFDataResponse<MovieResponse>) in
    
                completion(response)
        }
    }
    
    static func getTVSeries(page: Int, path: String, query: String?, completion: @escaping (AFDataResponse<TVSerieResponse>) -> ()) {
       
       var urlComponents = URLComponents()
       urlComponents.host = AppConfiguration.host
       urlComponents.path = path
       urlComponents.scheme = urlScheme
       
       urlComponents.queryItems = [
           URLQueryItem(name: "api_key", value: AppConfiguration.apiKey),
           URLQueryItem(name: "language", value: AppConfiguration.language),
           URLQueryItem(name: "page", value: "\(page)")
       ]
       
       if let query = query, !query.isEmpty {
            urlComponents.queryItems?.append(
                URLQueryItem(name: "query", value: query)
            )
        }
        
       AF.request(urlComponents.string!, method: .get, encoding: URLEncoding.default, headers: nil)
           .validate(statusCode: 200..<600)
           .responseDecodable { (response: AFDataResponse<TVSerieResponse>) in
           
           completion(response)
       }
   }
    
    static func getCrewAndCast(urlPath path: String, completion: @escaping (AFDataResponse<CreditsResponse>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = AppConfiguration.host
        urlComponents.path = path
        urlComponents.scheme = urlScheme
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: AppConfiguration.apiKey),
            URLQueryItem(name: "language", value: AppConfiguration.language)
        ]
        
        AF.request(urlComponents.string!, method: .get, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseDecodable { (response: AFDataResponse<CreditsResponse>) in
            
            completion(response)
        }
    }
    
    static func getMovieGenres(completion: @escaping (AFDataResponse<GenreResponse>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = AppConfiguration.host
        urlComponents.path = URLPath.movieGenres
        urlComponents.scheme = urlScheme
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: AppConfiguration.apiKey),
            URLQueryItem(name: "language", value: AppConfiguration.language)
        ]
        
        AF.request(urlComponents.string!, method: .get, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseDecodable { (response: AFDataResponse<GenreResponse>) in
            
            completion(response)
        }
    }
    
    static func getTVSerieGenres(completion: @escaping (AFDataResponse<GenreResponse>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = AppConfiguration.host
        urlComponents.path = URLPath.tvSerieGenres
        urlComponents.scheme = urlScheme
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: AppConfiguration.apiKey),
            URLQueryItem(name: "language", value: AppConfiguration.language)
        ]
        
        AF.request(urlComponents.string!, method: .get, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseDecodable { (response: AFDataResponse<GenreResponse>) in
            
            completion(response)
        }
    }
}

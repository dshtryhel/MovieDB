//
//  GenreRepository.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Foundation
import RxSwift

class GenreRepository {
    
    func getMovieGenreList() {
        AlamofireService.getMovieGenres(completion: { (response) in
            
            do {
                let genres = try response.result.get().genres

                ApplicationVariables.movieGenreList = genres
            } catch {
                print("‼️ Failed. (getMovieGenreList) -> Error: ", response.error!.localizedDescription)
                return
            }
            
        })
    }
    
    func getTVSerieGenreList() {
        AlamofireService.getTVSerieGenres(completion: { (response) in
            
            do {
                let genres = try response.result.get().genres

                ApplicationVariables.tvSerieGenreList = genres
            } catch {
                print("‼️ Failed. (getTVSerieGenreList) -> Error: ", response.error!.localizedDescription)
                return
            }

        })
    }
}


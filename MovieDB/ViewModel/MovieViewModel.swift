//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Foundation
import RxSwift

final class MovieViewModel {
    
    let disposeBag = DisposeBag()
    
    let movieRepository = MovieRespository()
    
    let genreRepository = GenreRepository()
    
    let topRatedMovieResponse = PublishSubject<MovieResponse>()
    
    var topRatedMovieList: [MovieResult] = []
    
    let nowPlayingMovieResponse = PublishSubject<MovieResponse>()
    
    var nowPlayingMovieList: [MovieResult] = []
    
    let popularMovieResponse = PublishSubject<MovieResponse>()
    
    var popularMovieList: [MovieResult] = []
    
    // MARK: fetchTopRatedMovieList
    func fetchTopRatedMovieList() {
          
        movieRepository
            .getTopRatedMovieList(page: ItemServiceParams.page).subscribe(onNext: { [weak self] (topRatedMovieResponse) in
                
                if let topRatedMovieList = topRatedMovieResponse.results {
                    self?.topRatedMovieList = topRatedMovieList
                }
              self?.topRatedMovieResponse.onNext(topRatedMovieResponse)
              
          }, onError: { [weak self] (error) in
              self?.topRatedMovieResponse.onError(error)
          })
          .disposed(by: disposeBag)
      }
    
    // MARK: fetchNowPlayingMovieList
    func fetchNowPlayingMovieList() {
        
        movieRepository
            .getNowPlayingMovieList(page: ItemServiceParams.page).subscribe(onNext: { [weak self] (nowPlayingMovieResponse) in
              
              if let nowPlayingMovieList = nowPlayingMovieResponse.results {
                  self?.nowPlayingMovieList = nowPlayingMovieList
              }
            self?.nowPlayingMovieResponse.onNext(nowPlayingMovieResponse)
            
        }, onError: { [weak self] (error) in
            self?.nowPlayingMovieResponse.onError(error)
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: fetchPopularMovieList
    func fetchPopularMovieList() {
        
        movieRepository
            .getPopularMovieList(page: ItemServiceParams.page).subscribe(onNext: { [weak self] (popularMovieResponse) in
              
              if let popularMovieList = popularMovieResponse.results {
                  self?.popularMovieList = popularMovieList
              }
            self?.popularMovieResponse.onNext(popularMovieResponse)
            
        }, onError: { [weak self] (error) in
            self?.popularMovieResponse.onError(error)
        })
        .disposed(by: disposeBag)
    }
    
    func fetchMovieGenreList() {
        genreRepository.getMovieGenreList()
    }
}

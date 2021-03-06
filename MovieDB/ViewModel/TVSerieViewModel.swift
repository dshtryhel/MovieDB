//
//  TVSerieViewModel.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Foundation
import RxSwift

final class TVSerieViewModel {
    
    let disposeBag = DisposeBag()
    
    let tvSerieRepository = TVSerieRepository()
    
    let genreRepository = GenreRepository()
    
    let tvSerieResponse = PublishSubject<TVSerieResponse>()
    
    var tvSerieList: [TVSerieResult] = []
    
    let popularTVSerieResponse = PublishSubject<TVSerieResponse>()
    
    var popularTVSerieList: [TVSerieResult] = []
    
    func fetchTopRatedTVSerieList() {
          
          tvSerieRepository
            .getTopRatedTVSerieList(page: ItemServiceParams.page).subscribe(onNext: { [weak self] (tvSerieResponse) in
                
                if let tvSerieList = tvSerieResponse.results {
                    self?.tvSerieList = tvSerieList
                }
              self?.tvSerieResponse.onNext(tvSerieResponse)
              
          }, onError: { [weak self] (error) in
              self?.tvSerieResponse.onError(error)
          })
          .disposed(by: disposeBag)
      }
    
    func fetchPopularTVSerieList() {
        
        tvSerieRepository
            .getPopularTVSerieList(page: ItemServiceParams.page).subscribe(onNext: { [weak self] (popularTVSerieResponse) in
              
              if let popularTVSerieList = popularTVSerieResponse.results {
                  self?.popularTVSerieList = popularTVSerieList
              }
            self?.popularTVSerieResponse.onNext(popularTVSerieResponse)
            
        }, onError: { [weak self] (error) in
            self?.popularTVSerieResponse.onError(error)
        })
        .disposed(by: disposeBag)
    }
    
    func fetchTVSerieGenreList() {
        genreRepository.getTVSerieGenreList()
    }
}


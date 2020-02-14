//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Foundation
import RxSwift

final class MovieDetailViewModel {
    
    let disposeBag = DisposeBag()
    
    let creditsRepository = CreditsRepository()
    
    let movie = BehaviorSubject<MovieResult?>(value: nil)
    
    let creditsResponse = PublishSubject<CreditsResponse>()
    
    var crewList: [CrewData] = []
    
    var castList: [CastData] = []
    
    let tvSerie = BehaviorSubject<TVSerieResult?>(value: nil)
    
    func fetchMovieCharacterList(movieId id: Int) {
        
        let urlPath = "/\(AppConfiguration.apiVersion)/movie/\(id)/credits"
        
        creditsRepository
            .getCrewAndCastList(urlPath: urlPath).subscribe(onNext: { [weak self] (creditsResponse) in
                
                if let crewList = creditsResponse.crew {
                    self?.crewList = crewList                }
                
                if let castList = creditsResponse.cast {
                    self?.castList = castList
                }
                self?.creditsResponse.onNext(creditsResponse)
                
                }, onError: { [weak self] (error) in
                    self?.creditsResponse.onError(error)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchTVSerieCharacterList(tvSerieId id: Int) {
        
        let urlPath = "/\(AppConfiguration.apiVersion)/tv/\(id)/credits"
        
        creditsRepository
            .getCrewAndCastList(urlPath: urlPath).subscribe(onNext: { [weak self] (tvSerieCreditsResponse) in
                
                if let tvSerieCrewList = tvSerieCreditsResponse.crew {
                    self?.crewList = tvSerieCrewList
                }
                
                if let movieCastList = tvSerieCreditsResponse.cast {
                    self?.castList = movieCastList
                }
                self?.creditsResponse.onNext(tvSerieCreditsResponse)
                
                }, onError: { [weak self] (error) in
                    self?.creditsResponse.onError(error)
            })
            .disposed(by: disposeBag)
    }
}



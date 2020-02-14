//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 21.01.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import RxSwift

final class SearchViewModel {

    // MARK: - public properties
    let disposeBag = DisposeBag()
    
    var movieList: [MovieResult] = []
    
    var tvSerieList: [TVSerieResult] = []
    
    let movieResponse = PublishSubject<MovieResponse>()
    
    let tvSerieResponse = PublishSubject<TVSerieResponse>()
    
    var listType = ""
    
    var itemCount: Int!
    
    // MARK: - private properties
    private let movieRepository = MovieRespository()
    
    private let tvSerieRepository = TVSerieRepository()
    
    private var searchText: String?
    
    private let scopeTitles = ["Movies", "TV Series"]
    
    private var pagination = false
    
    func resetResults() {
        movieList = []
        tvSerieList = []
    }
    
    func fetchMovieList() {
        
        movieRepository
            .getRequestedMovieList(page: ItemServiceParams.page, query: searchText).subscribe(onNext: {
                [weak self] (movieResponse) in
                guard let strongSelf = self else { return }
            if let movieList = movieResponse.results {
                strongSelf.movieList += movieList
                strongSelf.itemCount = strongSelf.movieList.count
                strongSelf.pagination = false
                
                ItemServiceParams.page = movieResponse.page ?? 1
                ItemServiceParams.totalPages = movieResponse.totalPages ?? 1
            }
            self?.movieResponse.onNext(movieResponse)
                
            }, onError: { [weak self] (error) in
                self?.movieResponse.onError(error)
            })
        .disposed(by: disposeBag)
    }
    
    func fetchTVSeriesList() {
        
        tvSerieRepository
            .getRequestedTVSerieList(page: ItemServiceParams.page, query: searchText)
            .subscribe(onNext: { [weak self] (tvSerieResponse) in
                guard let strongSelf = self else { return }
            if let tvSerieList = tvSerieResponse.results {
                strongSelf.tvSerieList = tvSerieList
                strongSelf.itemCount = strongSelf.tvSerieList.count
                ItemServiceParams.page = tvSerieResponse.page ?? 1
                ItemServiceParams.totalPages = tvSerieResponse.totalPages ?? 1
            }
                self?.tvSerieResponse.onNext(tvSerieResponse)
                
            }, onError: { [weak self] (error) in
                self?.tvSerieResponse.onError(error)
            })
        .disposed(by: disposeBag)
    }
    
    func fetchSearchItem(category: String) {
        
        switch category {
            case "Movies": fetchMovieList()
            case "TV Series": fetchTVSeriesList()
        default: break
            
        }
    }
    
    func searchItemDidChange(index: Int, text: String?) {

        self.listType = scopeTitles[index]

        if let searchText = text {
            resetResults()
            self.searchText = searchText
            fetchSearchItem(category: listType)
        }
        
    }
    
    func loadNextPage() {

        guard !pagination, ItemServiceParams.page <= ItemServiceParams.totalPages
            else { return }
        pagination = true
        ItemServiceParams.page += 1
        fetchSearchItem(category: self.listType)
    }
    
}

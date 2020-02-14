//
//  MovieRepository.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Foundation
import RxSwift

class MovieRespository {
    
    func getTopRatedMovieList(page: Int) -> Observable<MovieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getMovies(page: page, path: URLPath.topRatedMovies, query: nil, completion: { (response) in
                
                do {
                    let data = try response.result.get()
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    print("‼️ Failed. (getTopRatedMovies) -> Error: ", response.error!.localizedDescription)
                    observer.onError(response.error!)
                    return
                }

            })
            return Disposables.create()
        })
    }
    
    func getNowPlayingMovieList(page: Int) -> Observable<MovieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getMovies(page: page, path: URLPath.nowPlayingMovies, query: nil, completion: { (response) in
                
                do {
                    let data = try response.result.get()
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    print("‼️ Failed. (getNowPlayingMovieList) -> Error: ", response.error!.localizedDescription)
                    observer.onError(response.error!)
                    return
                }

            })
            return Disposables.create()
        })
    }
    
    func getPopularMovieList(page: Int) -> Observable<MovieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getMovies(page: page, path: URLPath.popularMovies, query: nil, completion: { (response) in
                
                do {
                    let data = try response.result.get()
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    print("‼️ Failed. (getPopularMovieList) -> Error: ", response.error!.localizedDescription)
                    observer.onError(response.error!)
                    return
                }

            })
            return Disposables.create()
        })
    }
    
    func getRequestedMovieList(page: Int, query: String?) -> Observable<MovieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getMovies(page: page, path: URLPath.movieSearch, query: query, completion: { (response) in
                do {
                    let data = try response.result.get()
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    print("‼️ Failed. (getRequestedMovieList) -> Error: ", response.error!.localizedDescription)
                    observer.onError(response.error!)
                    return
                }
            })
            return Disposables.create()
        })
    }
    
}

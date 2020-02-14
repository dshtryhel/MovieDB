//
//  TVSerieRepository.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Foundation
import RxSwift

class TVSerieRepository {
    
    func getTopRatedTVSerieList(page: Int) -> Observable<TVSerieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getTVSeries(page: page, path: URLPath.topRatedTVSeries, query: nil, completion: { (response) in
                
                do {
                    let data = try response.result.get()
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    print("‼️ Failed. (getTopRatedTVSerieList) -> Error: ", response.error!.localizedDescription)
                    observer.onError(response.error!)
                    return
                }

            })
            return Disposables.create()
        })
    }
    
    func getPopularTVSerieList(page: Int) -> Observable<TVSerieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getTVSeries(page: page, path: URLPath.popularTVSeries, query: nil, completion: { (response) in
                
                do {
                    let data = try response.result.get()
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    print("‼️ Failed. (getPopularTVSerieList) -> Error: ", response.error!.localizedDescription)
                    observer.onError(response.error!)
                    return
                }
                
            })
            return Disposables.create()
        })
    }
    
    func getRequestedTVSerieList(page: Int, query: String?) -> Observable<TVSerieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getTVSeries(page: page, path: URLPath.tvSerieSearch, query: query, completion: {
                (response) in
                
                do {
                    let data = try response.result.get()
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    observer.onError(response.error!)
                }
            })
            return Disposables.create()
        })
        
    }
}

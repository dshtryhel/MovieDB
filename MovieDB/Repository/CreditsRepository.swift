//
//  MovieCreditsRepository.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import Foundation
import RxSwift

class CreditsRepository {
    
    func getCrewAndCastList(urlPath path: String) -> Observable<CreditsResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getCrewAndCast(urlPath: path, completion: { (response) in
                
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
}


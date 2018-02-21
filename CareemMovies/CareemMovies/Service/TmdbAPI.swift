//
//  TmdbAPI.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

/*
 * Class TmdbAPI adopts protocol FetchRequester and fetchs movies list from TMDB service
 * with help of Alamofire
 * ResponseParser instance is expernal dependency and can parse any type of response
 */

class TmdbAPI: FetchRequester {
    
    private let urlTemplate = "http://api.themoviedb.org/3/search/movie?api_key=%@&query=%@&page=%d"
    private let responseParser: ResponseParser
    
    init(responseParser: ResponseParser) {
        self.responseParser = responseParser
    }
    
    func fetchMoviesList(by name: String, on page: Int)  -> Observable<(request: String, response: MoviesResponse)> {
        let url = tmdbUrl(by: name, on: page)
        
        //usage of Observable helps to forvard outside valid parsed data or error
        return Observable<(request: String, response: MoviesResponse)>.create({[unowned self] (observer) -> Disposable in
            Alamofire.request(url).responseData {(response) in
                DispatchQueue.global(qos: .default).async {[weak self] in
                    guard let this = self else {
                            return
                    }
                    
                    if let error = response.error {
                        observer.onError(FetchError.networkError(error))
                        return
                    }
                    
                    let result = this.responseParser.parse(data: response.result.value)
                    switch result {
                    case .data(let response):
                        if response.movies.count > 0 {
                            observer.onNext((request: name, response: response))
                        } else {
                            observer.onError(FetchError.noData)
                        }
                    case .error(let error):
                        observer.onError(FetchError.parseError(error))
                    }
                }
            }
            
            return Disposables.create()
        })
        
    }
        
    //MARK: - Private
    
    private func tmdbUrl(by name: String, on page: Int) -> String {
        return String(format: urlTemplate, TMDB.apiKey, name, page)
    }
    
}

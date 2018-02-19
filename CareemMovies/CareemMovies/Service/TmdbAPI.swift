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

class TmdbAPI: FetchRequester {
    
    private let urlTemplate = "http://api.themoviedb.org/3/search/movie?api_key=%@&query=%@&page=%d"
    private let responseParser: ResponseParser
    
    init(responseParser: ResponseParser) {
        self.responseParser = responseParser
    }
    
    func fetchMoviesList(by name: String, on page: Int)  -> Observable<MoviesResponse> {
        let url = tmdbUrl(by: name, on: page)
        
        return Observable<MoviesResponse>.create({[unowned self] (observer) -> Disposable in
            Alamofire.request(url).responseData {(response) in
                DispatchQueue.global(qos: .default).async {[weak self] in
                    guard let this = self else {
                            return
                    }
                    
                    let result = this.responseParser.parse(data: response.data)
                    switch result {
                    case .data(let response):
                        observer.onNext(response)
                    case .error(let error):
                        observer.onError(FetchError.parseError(""))
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

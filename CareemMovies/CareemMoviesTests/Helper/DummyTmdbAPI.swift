//
//  DummyTmdbAPI.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 22.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import RxSwift

enum DummyApiResult {
    case valid
    case error
    case empty
}

class DummyTmdbAPI: FetchRequester {
    
    var expectedResult: DummyApiResult = .valid
    
    func fetchMoviesList(by name: String, on page: Int)  -> Observable<(request: String, response: FetchResult)> {

        return Observable<(request: String, response: FetchResult)>.create({[unowned self] (observer) -> Disposable in
            
            switch self.expectedResult {
            case .valid:
                let response = DummyMovie.movieResponseSample()
                observer.onNext((request: name, response: .response(response)))
            case .error:
                observer.onNext((request: name, response:.error(FetchError.parseError(.InvalidData))))
            case .empty:
                observer.onNext((request: name, response:.error(FetchError.noData)))
            }
            
            return Disposables.create()
        })
        
    }
    
}


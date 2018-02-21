//
//  FetchRequester.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import RxSwift

/*
 * Protocol FetchRequester defines common interface for fetch movies from any source
 */

enum FetchError: Error {
    case networkError(Error)
    case parseError(ParseError)
    case noData
}

enum FetchResult{
    case error(FetchError)
    case response(MoviesResponse)
}

protocol FetchRequester {
    func fetchMoviesList(by name: String, on page: Int) -> Observable<(request: String, response: FetchResult)>
}

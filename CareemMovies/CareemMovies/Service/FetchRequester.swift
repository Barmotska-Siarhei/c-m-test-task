//
//  FetchRequester.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

enum FetchResult {
    case data(MoviesResponse)
    case error(FetchError)
}

enum FetchError {
    case ParseError(String)
}

protocol FetchRequester {
    func fetchMoviesList(by name: String, on page: Int)
    func set(onCompleted callback: ((FetchResult) -> ())?) -> FetchRequester
}

//
//  FetchRequester.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import RxSwift

enum FetchError: Error {
    case parseError(String)
}

protocol FetchRequester {
    func fetchMoviesList(by name: String, on page: Int) -> Observable<MoviesResponse>
}

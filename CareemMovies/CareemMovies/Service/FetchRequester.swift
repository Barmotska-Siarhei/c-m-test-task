//
//  FetchRequester.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

protocol FetchRequester {
    func getMoviesList(by name: String, on page: Int) -> [Movie]
}

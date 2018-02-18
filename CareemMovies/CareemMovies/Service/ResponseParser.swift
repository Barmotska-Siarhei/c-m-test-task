//
//  ResponseParser.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 18.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

enum ParseError: String {
    case Empty
    case InvalidData
}

enum ParseResult {
    case data(MoviesResponse)
    case error(ParseError)
}

protocol ResponseParser {
    func parse(data: Data?) -> ParseResult
}

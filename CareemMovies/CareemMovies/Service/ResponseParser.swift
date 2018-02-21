//
//  ResponseParser.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 18.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation


/*
 * Protocol ResponseParser defines common interface for parsing Data object, which could by gotten
 * from any source and could contain any data type (JSON, XML and etc).
 */

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

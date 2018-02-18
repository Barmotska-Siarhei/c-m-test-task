//
//  Movie.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
}

struct Movie: Codable {
    let name: String
    let year: String
    let imagePath: String?
    let movieDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "original_title"
        case year = "release_date"
        case imagePath = "poster_path"
        case movieDescription = "overview"
    }
}

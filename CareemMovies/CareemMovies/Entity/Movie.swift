//
//  Movie.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

/*
 *  Struct MoviesResponse incapsulates whole JSON response from TMDB service
 *  Usage of "Codable" protocol from Swift 4 helps to map JSON to object properties
 */

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

/*
 *  Struct Movie incapsulates whole Movie object of MoviesResponse
 *  Usage of "Codable" protocol from Swift 4 helps to map JSON to object properties
 */

struct Movie: Codable {
    let name: String
    let year: String
    let imagePath: String?
    let movieDescription: String?
    
    enum MoviePosterSize: String {
        case w92
        case w185
        case w500
        case w780
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "original_title"
        case year = "release_date"
        case imagePath = "poster_path"
        case movieDescription = "overview"
    }
}

// Extension builds full path to image assets on the base of image size type and last path component
extension Movie {
    func fullImagePath(for size: MoviePosterSize) -> String? {
        guard let concreteImage = imagePath else {
            return nil
        }
        
        return "http://image.tmdb.org/t/p/" +  size.rawValue + concreteImage
    }
}

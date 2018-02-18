//
//  TmdbAPI.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import Alamofire

class TmdbAPI: FetchRequester {
    private let urlTemplate = "http://api.themoviedb.org/3/search/movie?api_key=%@&query=%@&page=%d"
    
    func getMoviesList(by name: String, on page: Int) -> [Movie] {
        let url = tmdbUrl(by: name, on: page)
      
        Alamofire.request(url).responseJSON { (response) in
            print(response)
        }
        
        return []
    }
    
    //MARK: - Private
    private func tmdbUrl(by name: String, on page: Int) -> String {
        return String(format: urlTemplate, TMDB.apiKey, name, page)
    }
    
}

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
    
    private let responseParser: ResponseParser
    
    init(responseParser: ResponseParser) {
        self.responseParser = responseParser
    }
    
    func getMoviesList(by name: String, on page: Int) -> [Movie] {
        let url = tmdbUrl(by: name, on: page)
      
        Alamofire.request(url).responseData {[weak self] (response) in
            guard let this = self else {
                return
            }
            
            let result = this.responseParser.parse(data: response.data)
            print(result)
        }
        
        return []
    }
    
    //MARK: - Private
    private func tmdbUrl(by name: String, on page: Int) -> String {
        return String(format: urlTemplate, TMDB.apiKey, name, page)
    }
    
}

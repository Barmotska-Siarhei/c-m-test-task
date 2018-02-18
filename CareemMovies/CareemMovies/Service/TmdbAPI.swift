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
    private var onComleted: ((FetchResult) -> ())?
    
    init(responseParser: ResponseParser) {
        self.responseParser = responseParser
    }
    
    func fetchMoviesList(by name: String, on page: Int) {
        let url = tmdbUrl(by: name, on: page)
      
        Alamofire.request(url).responseData {(response) in
           
            DispatchQueue.global(qos: .default).async {[weak self] in
                guard let this = self,
                    let callback = this.onComleted else {
                        return
                }
                
                let result = this.responseParser.parse(data: response.data)
                switch result {
                case .data(let response):
                    callback(.data(response))
                case .error(let error):
                    callback(.error(.ParseError(error.rawValue)))
                }
            }
            
        }
    }
    
    func set(onCompleted callback: ((FetchResult) -> ())?) -> FetchRequester {
        self.onComleted = callback
        return self
    }
    
    //MARK: - Private
    private func tmdbUrl(by name: String, on page: Int) -> String {
        return String(format: urlTemplate, TMDB.apiKey, name, page)
    }
    
}

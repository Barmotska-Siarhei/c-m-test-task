//
//  ResponseJSONParser.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 18.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

class ResponseJSONParser: ResponseParser {
    
    func parse(data: Data?) -> ParseResult {
        guard let responseData = data else {
            return .error(.Empty)
        }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(MoviesResponse.self, from: responseData)
            return .data(result)
        } catch {
            print("Invalid response data")
            return .error(.InvalidData)
        }
    }
    
}

//
//  DummyMovie.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 22.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

class DummyMovie {
    
    static let json = "{\"page\":1,\"total_results\":2,\"total_pages\":1,\"results\":[{\"vote_count\":2575,\"id\":268,\"video\":false,\"vote_average\":7,\"title\":\"Batman\",\"popularity\":27.849568,\"poster_path\":\"kBf3g9crrADGMc2AMAMlLBgSm2h.jpg\",\"original_language\":\"en\",\"original_title\":\"Batman\",\"genre_ids\":[14,28],\"backdrop_path\":\"2blmxp2pr4BhwQr74AdCfwgfMOb.jpg\",\"adult\":false,\"overview\":\"The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld.\",\"release_date\":\"1989-06-23\"},{\"vote_count\":8772,\"id\":272,\"video\":false,\"vote_average\":7.5,\"title\":\"Batman Begins\",\"popularity\":47.683164,\"poster_path\":\"dr6x4GyyegBWtinPBzipY02J2lV.jpg\",\"original_language\":\"en\",\"original_title\":\"Batman Begins\",\"genre_ids\":[28,80,18],\"backdrop_path\":\"65JWXDCAfwHhJKnDwRnEgVB411X.jpg\",\"adult\":false,\"overview\":\"Driven by tragedy, billionaire Bruce Wayne dedicates his life to uncovering and defeating the corruption that plagues his home, Gotham City.Unable to work within the system, he instead creates a new identity, a symbol of fear for the criminal underworld - The Batman.\",\"release_date\":\"2005-06-10\"}]}"
    
    static func movieResponseSample() -> MoviesResponse {
    
        let data = json.data(using: .utf8)
        let decoder = JSONDecoder()
        let result = try! decoder.decode(MoviesResponse.self, from: data!)
       
        return result
    }
}

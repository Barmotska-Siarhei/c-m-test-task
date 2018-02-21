//
//  MovieTests.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 22.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import XCTest

class MovieTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFullPath() {
        //given
        let movie = Movie(name: "Batman", year: "2018", imagePath: "/theBat.png", movieDescription: "No")
        
        //when  -> TODO in production code (should be verified the other sizes)
        let fullPath = movie.fullImagePath(for: .w185)
        
        //then
        XCTAssertTrue(fullPath == "http://image.tmdb.org/t/p/w185/theBat.png", "Image full path ")
    }
    
}

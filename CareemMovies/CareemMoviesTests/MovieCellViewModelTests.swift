//
//  MovieCellViewModelTests.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 22.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import XCTest

class MovieCellViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        //given
        let response = DummyMovie.movieResponseSample()
        let movie = response.movies.first
        
        //when
        let model = MovieCellViewModel(movie: movie!)
        
        //then
        XCTAssertTrue(model.name.value == "Batman", "Movie name")
        XCTAssertTrue(model.year.value == "(1989-06-23)", "Release date")
        XCTAssertTrue(model.description.value == "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham\'s underworld.", "Movie description")
    }
    
}

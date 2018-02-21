//
//  MoviesListViewModelTests.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 22.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import XCTest
import RxSwift

class MoviesListViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStart() {
        //given
        let dummyFetchAPI = DummyTmdbAPI()
        dummyFetchAPI.expectedResult = .valid
        let dummyPersistent = DummyDataBaseProvider()
        let persistentProvider = AnyPersistentProvider<String>(sourceProvider: dummyPersistent)
        let model = MoviesListViewModel(fetchAPI: dummyFetchAPI, persistentStore: persistentProvider)
        let disposeBag = DisposeBag()
        
        let expectation = XCTestExpectation(description: #function)
        
        //when
        model.movies
            .observeOn(MainScheduler.instance)
            .subscribe( onNext: {(result) in
                switch result {
                case .error:
                    break
                case .movie(let movies):
                    XCTAssertTrue(movies.count == 2, "2 fetched movies")
                    expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        model.startMovieFetcherDaemon()
        model.filmName.onNext("Batman")
        
        //then
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    func testSuggestions() {
        //given
        let dummyFetchAPI = DummyTmdbAPI()
        dummyFetchAPI.expectedResult = .valid
        let dummyPersistent = DummyDataBaseProvider()
        let persistentProvider = AnyPersistentProvider<String>(sourceProvider: dummyPersistent)
        let model = MoviesListViewModel(fetchAPI: dummyFetchAPI, persistentStore: persistentProvider)
        
        //when
        model.startMovieFetcherDaemon()
        
        //then
        let suggestions = model.suggestions()
        XCTAssertTrue(suggestions.count == 10, "10 suggestions from persistent store")
        XCTAssertTrue(suggestions.first == "12", "The last request should be first item")
    }
    
}

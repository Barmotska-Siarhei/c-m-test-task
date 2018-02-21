//
//  TmdbAPITests.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 22.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import XCTest
import Nocilla
import RxSwift

class TmdbAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        LSNocilla.sharedInstance().start()
    }
    
    
    override func tearDown() {
        super.tearDown()
        LSNocilla.sharedInstance().clearStubs()
        LSNocilla.sharedInstance().stop()
    }
    
    func testFetch() {
        //given
        let fetchAPI = TmdbAPI(responseParser: ResponseJSONParser())
        let disposeBag = DisposeBag()
        
        //when
        stubTMBDResponse()
        
        let exp = expectation(description: #function)
        stubTMBDResponse()
        
        fetchAPI.fetchMoviesList(by: "Batman", on: 1)
            .subscribe(onNext: {(result) in
                let resultresponse = result.response
                switch resultresponse {
                case .error:
                    XCTFail("Invalid fetch result")
                case .response(let response):
                    XCTAssertTrue(response.movies.count == 2, "2 fetched objects")
                    exp.fulfill()
                    break
                }
            })
            .disposed(by: disposeBag)
       
        //then
        wait(for: [exp], timeout: 1.0)
    }
    
}

extension TmdbAPITests {
    fileprivate func stubTMBDResponse() {
        let url = "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=Batman&page=1" as NSString

        let jsonString = DummyMovie.json
        let data = jsonString.data(using: .utf8)
        
        let _ = stubRequest("GET", url).andReturnRawResponse(data)
    }
}

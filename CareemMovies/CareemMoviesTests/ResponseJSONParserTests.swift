//
//  ResponseJSONParserTests.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 22.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import XCTest

class ResponseJSONParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidData() {
        //given
        let jsonString = DummyMovie.json
        let data = jsonString.data(using: .utf8)
        let jsonparser = ResponseJSONParser()
        
        //when
        let result = jsonparser.parse(data: data)
        
        //then
        switch result {
        case .data(let response):
            XCTAssert(response.movies.count == 2, "Valid parsed object")
        case .error:
            XCTFail("Parse error")
        }
    }
    
    
    func testInvalidData() {
        //given
        let jsonString = "bla-bla"
        let data = jsonString.data(using: .utf8)
        let jsonparser = ResponseJSONParser()
        
        //when
        let result = jsonparser.parse(data: data)
        
        //then
        switch result {
        case .data(_):
            XCTFail("Parse error")
        case .error:
            break
        }
    }
    
}

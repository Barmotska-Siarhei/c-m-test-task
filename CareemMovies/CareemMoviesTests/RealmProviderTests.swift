//
//  RealmProviderTests.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 22.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import XCTest

class RealmProviderTests: XCTestCase {
    
    func testInit() {
        //given when
        let provider = RealmProvider.realm
        
        //then
        XCTAssertNotNil(provider, "Valid Realm provoder")
    }
    
}

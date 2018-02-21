//
//  CoordinatorTests.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 21.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import XCTest
import UIKit

class CoordinatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        //given
        let vc = UIViewController()
        
        //when
        let coordinator = AppCoordinator(baseViewController: vc)
        
        //then
        XCTAssertTrue(coordinator.baseVC == vc, "Invalid base vc")
    }
    
}

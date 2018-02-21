//
//  DummyDataBaseProvider.swift
//  CareemMoviesTests
//
//  Created by Siarhei Barmotska on 22.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

class DummyDataBaseProvider: PersistentProvider {
    typealias ItemType = String
    
    func save(object: String) {
    }
    
    func allObjects() -> [String] {
        return ["1","2","3","4","5","6","7","8","9","10","11","12"]
    }
    
}

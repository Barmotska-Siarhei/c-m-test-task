//
//  RealmProvider.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 19.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider {
    
    /// Instance of Realm database according to current process. In case of tests returns instance for test database file.
    ///
    /// - Returns: instance of Realm
    class func realm() -> Realm {
        if let _ = NSClassFromString("XCTest") {
            return try! Realm(configuration: Realm.Configuration(fileURL: nil,
                                                                 inMemoryIdentifier: "test",
                                                                 encryptionKey: nil,
                                                                 readOnly: false,
                                                                 schemaVersion: 0,
                                                                 migrationBlock: nil,
                                                                 objectTypes: nil))
        } else {
            return try! Realm();
            
        }
    }
    
    /// Clean all data in database
    class func cleanDatabase() {
        let realm = RealmProvider.realm()
        try! realm.write { () -> Void in
            realm.deleteAll()
        }
    }
}


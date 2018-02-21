//
//  DataBaseProvider.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 19.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import RealmSwift

/*
 * Class DataBaseProvider adopts protocol PersistentProvider and stores or loads object from
 * Realm database.
 */

class DataBaseProvider: PersistentProvider {
    typealias ItemType = String
    
    private var maxCount: Int = 10
    
    func save(object: String) {
        let realm = RealmProvider.realm()
        try! realm.write {
            let request = MovieRequest(name: object)
            realm.create(MovieRequest.self, value: request, update: true)
        }
    }
    
    func allObjects() -> [String] {
        let realm = RealmProvider.realm()
        //try to get successful requests from database
        let requests = Array(realm.objects(MovieRequest.self).map{ $0.name })
        return requests
    }
    
}

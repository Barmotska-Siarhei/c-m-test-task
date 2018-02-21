//
//  MovieRequest.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 19.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import RealmSwift

/*
 *  Struct MovieRequest incapsulates last successful request
 *  and main purpose of this object is storing in Realm database
 */

class MovieRequest: Object {
    @objc dynamic var name: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
}

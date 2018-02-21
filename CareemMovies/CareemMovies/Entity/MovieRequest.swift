//
//  MovieRequest.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 19.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import RealmSwift

class MovieRequest: Object {
    @objc dynamic var name: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

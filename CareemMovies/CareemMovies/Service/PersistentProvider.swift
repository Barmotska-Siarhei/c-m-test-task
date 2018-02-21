//
//  PersistentProvider.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 19.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

protocol PersistentProvider {
    associatedtype ItemType
   
    func save(object: ItemType)
    func allObjects() -> [ItemType]
}

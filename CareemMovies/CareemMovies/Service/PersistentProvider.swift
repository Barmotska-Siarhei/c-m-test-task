//
//  PersistentProvider.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 19.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

/*
 * Protocol PersistentProvider defines common interface for persistent storing of objects.
 * Defines only two methods  - save single object
 *                           - retrieve list of stored objects
 */

protocol PersistentProvider {
    associatedtype ItemType
   
    func save(object: ItemType)
    func allObjects() -> [ItemType]
}

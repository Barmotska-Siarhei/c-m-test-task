//
//  AnyPersistentProvider.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 20.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

// "Type Erasure" pattern is used to resolve compile error "Protocol 'PersistentProvider' can only be used as a generic constraint because it has Self or associated type requirements"

class AnyPersistentProvider<ElementType>: PersistentProvider {
    typealias ItemType = ElementType
    
    private let saveHandler: (ItemType) -> ()
    private let allObjectsHandler: () -> [ItemType]
    
    func save(object: ItemType) {
        saveHandler(object)
    }
    
    func allObjects() -> [ItemType] {
        return allObjectsHandler()
    }
    
    init<T: PersistentProvider>(sourceProvider: T) {
        saveHandler = sourceProvider.save as! ((ItemType) -> ())
        allObjectsHandler = sourceProvider.allObjects as! (() -> [ItemType])
    }
}

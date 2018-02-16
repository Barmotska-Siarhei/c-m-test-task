//
//  Coordinator.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 16.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

/*
 * Main purpose: create view model, viewcontroller, bind them and show view controller
 * and start other coordinators, if it is required
 */

import Foundation
import UIKit
import RxSwift

class Coordinator<ResultType> {
    typealias CoordinatorType = ResultType

    weak var baseVC: UIViewController?
    weak var customTransition: UIViewControllerTransitioningDelegate?
    
    private var childCoordinators: [String: Any] = [:]
    private let identifier = UUID().uuidString
    
    init(baseViewController vc: UIViewController?) {
        baseVC = vc
    }

    func start() -> Observable<ResultType> {
        assert(false, "Should be overriden in subclass" + NSStringFromClass(type(of: self)))
        return Observable.never()
    }

    func store<T>(coordinator: Coordinator<T>?) {
        guard let newCoordinator = coordinator else {
            return
        }

        childCoordinators[newCoordinator.identifier] = newCoordinator
    }

    func free<T>(coordinator: Coordinator<T>?) {
        guard let newCoordinator = coordinator else {
            return
        }

        childCoordinators.removeValue(forKey: newCoordinator.identifier)
    }

}



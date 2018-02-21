//
//  AppCoordinator.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import UIKit
import RxSwift

/*
 *  This coordinator class creates MoviesListViewController instance, injects all dependencies there
 *  and presents view controller on screen
 */

class AppCoordinator: Coordinator <Void>{
    
    override func start() -> Observable<Void> {
        showMoviesListVC()
        return Observable.never()
    }
    
    //MARK: - Private
    
    private func showMoviesListVC() {
        guard let nc = baseVC as? UINavigationController else {
            return
        }
        
        let fetchAPI = TmdbAPI(responseParser: ResponseJSONParser())
        let persistent = DataBaseProvider()
        let persistentProvider = AnyPersistentProvider<String>(sourceProvider: persistent)
        let model = MoviesListViewModel(fetchAPI: fetchAPI, persistentStore: persistentProvider)
        let moviesVC = MoviesListViewController.create(withViewModel: model)
        
        //show in navigation controller
        nc.setViewControllers([moviesVC], animated: true)
    }
}

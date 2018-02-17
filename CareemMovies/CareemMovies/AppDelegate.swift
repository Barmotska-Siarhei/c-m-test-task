//
//  AppDelegate.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 16.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator!
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupRootVC()
        return true
    }
    
    //MARK: - Private
    
    private func setupRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController()
        nc.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        coordinator = AppCoordinator(baseViewController: nc)
        let _ = coordinator?.start()
    }
}


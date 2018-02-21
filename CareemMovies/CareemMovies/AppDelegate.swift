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
        
        // avoid launching host app during unit-tests
        if ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil {
            return false
        }
        
        setupRootVC()
        return true
    }
    
    //MARK: - Private
    
    private func setupRootVC() {
        // Use coordinator to start first view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController()
        nc.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        coordinator = AppCoordinator(baseViewController: nc)
        let _ = coordinator?.start()
    }
}


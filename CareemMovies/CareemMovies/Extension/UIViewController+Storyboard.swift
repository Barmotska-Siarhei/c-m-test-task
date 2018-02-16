//
//  UIViewController+Storyboard.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 16.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func instantiateFromStoryboard(storyboardName: String, storyboardId: String) -> Self {
        return instantiateFromStoryboardHelper(storyboardName: storyboardName, storyboardId: storyboardId)
    }

    private class func instantiateFromStoryboardHelper<T>(storyboardName: String, storyboardId: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        return controller
    }
}

//
//  String+Localization.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 16.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

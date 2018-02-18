//
//  MovieCellViewModel.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation

import RxSwift
import Alamofire

class MovieCellViewModel {
    private let movie: Movie
    let name = Variable<String?>(nil)
    let year = Variable<String?>(nil)
    let description = Variable<String?>(nil)
   
    // Placeholder image could be used as initial value
    let image = Variable<UIImage?>(nil)
    
    init(movie: Movie) {
        self.movie = movie
        name.value = movie.name
        year.value = "(\(movie.year))"
        description.value = movie.movieDescription
        downloadImage()
    }
}

private extension MovieCellViewModel {
    private func downloadImage() {
        guard let url = movie.fullImagePath(for: .w500),
              let imageURL = URL(string: url) else {
            return
        }
      
        // Use Alamofire to download the image
        Alamofire.request(imageURL).responseData {[weak self] (response) in
            if let image = self?.image {
                if let data = response.data {
                    image.value = UIImage(data: data)
                }
            }
        }
    }
}

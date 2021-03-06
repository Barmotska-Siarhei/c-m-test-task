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

/*
 *  Movie List ViewModel services UICollectionViewCell class and prepare data for displaying there.
 *  I.e converts data from Movie class format to simple for displaying
 */

class MovieCellViewModel {
    private let movie: Movie
    let name = Variable<String?>(nil)
    let year = Variable<String?>(nil)
    let description = Variable<String?>(nil)

    let image = Variable<UIImage?>(placeholder)
    static private let placeholder = UIImage(named:"no_image")
    
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
      
        //use Alamofire to download the image
        Alamofire.request(imageURL).responseData {[weak self] (response) in
            if let image = self?.image {
                if let data = response.data {
                    image.value = UIImage(data: data)
                }
            }
        }
    }
}

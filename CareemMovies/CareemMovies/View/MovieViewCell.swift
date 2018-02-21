//
//  MovieViewCell.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 *  Subclass of UICollectionViewCell displays data from MovieCellViewModel instance
 *  All outlets are hidden to avoid MVC approach
 *  After cell reuse, the binding with the model is renewed
 */

final class MovieViewCell: UICollectionViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var posterView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private var model: MovieCellViewModel?
    private var disposeBag: DisposeBag?
    
    static let identifier = "MovieViewCell"
    
    //Single public method for cell content management
    func apply(model: MovieCellViewModel) {
        self.model = model
        
        let bag = DisposeBag()
        disposeBag = bag
        
        // bind movie details from model to cell UI controls
        model.name.asObservable()
            .bind(to: nameLabel.rx.text)
            .disposed(by: bag)
        
        model.year.asObservable()
            .bind(to: yearLabel.rx.text)
            .disposed(by: bag)
        
        model.description.asObservable()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: bag)
        
        //the placeholder image is shown until real image is downloaded
        //show placeholder immidiatly
        model.image.asObservable()
            .take(1)
            .subscribe(onNext: {[weak self] (image) in
                self?.posterView.image = image
            })
            .disposed(by: bag)
        
        //show poster image with animation.
        model.image.asObservable()
            .skip(1)
            .subscribe(onNext: {[weak self] (image) in
                guard let this = self else {
                    return
                }
                
                UIView.transition(with: this.posterView,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: { this.posterView.image = image },
                                  completion: nil)
            })
            .disposed(by: bag)
    }
    
    override func prepareForReuse() {
        //release disposebag instance to unsubscribe before cell reusage
        disposeBag = nil
    }
}

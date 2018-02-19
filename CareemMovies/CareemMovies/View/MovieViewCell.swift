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

final class MovieViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var model: MovieCellViewModel?
    private var disposeBag: DisposeBag?
    
    static let identifier = "MovieViewCell"
    
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
        
        //show placeholder immidiatly
        model.image.asObservable()
            .take(1)
            .subscribe(onNext: {[weak self] (image) in
                self?.posterView.image = image
            })
            .disposed(by: bag)
        
        //show poster image with animation
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
        //unsubscribe before cell reusage
        disposeBag = nil
    }
}

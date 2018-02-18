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
        
        model.name.asObservable()
            .bind(to: nameLabel.rx.text)
            .disposed(by: bag)
        
        model.year.asObservable()
            .bind(to: yearLabel.rx.text)
            .disposed(by: bag)
        
        model.image.asObservable()
            .bind(to: posterView.rx.image)
            .disposed(by: bag)
        
        model.description.asObservable()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: bag)
    }
    
    override func prepareForReuse() {
        disposeBag = nil
    }
}

//
//  MoviesListViewController.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var model: MoviesListViewModel!
    private let disposeBag = DisposeBag()
    
    private var arr: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIBindings()
        model.start()
    }
    
    //MARK: - Private
    
    private func setupUIBindings() {
        model.movies
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (movies) in
               self.arr = movies
               self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
}

extension MoviesListViewController {
    static func create(withViewModel model: MoviesListViewModel) -> MoviesListViewController {
        let vc = MoviesListViewController.instantiateFromStoryboard(storyboardName: StoryBoardName.main, storyboardId: "MoviesListViewController")
        vc.model = model
        return vc
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell {
            let movie = arr[indexPath.row]
            let model = MovieCellViewModel(movie: movie)
            cell.apply(model: model)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            if let searchBar = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier:
                SearchBarView.identifier, for: indexPath) as? SearchBarView {
              
                searchBar.searchBar.rx.searchButtonClicked
                    .withLatestFrom(searchBar.searchBar.rx.text)
                    .bind(to: self.model.filmName)
                    .disposed(by: disposeBag)
                
                return searchBar
            }
            
        default:
            break
        }
        
        return UICollectionReusableView()
    }
    
}


extension MoviesListViewController: UICollectionViewDelegate {
    
}


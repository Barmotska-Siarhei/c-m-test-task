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

/**
 *  View controller class contains UICollectionView, which displays the list
 *  of fetched movies and search bar, where a user could type interested movie name
 *  for search. Fetch request starts, when the user taps "Search" button on the keyboard.
 *  I didn't use RxCocoa to bind datasource and UICollectionView, because I will be able to
 *  listen to all callbacks and delegates from UICollectionView
 */

class MoviesListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var model: MoviesListViewModel!
    fileprivate let disposeBag = DisposeBag()
   
    fileprivate var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIBindings()
        model.startMovieFetcherDaemon()
    }
    
    //MARK: - Private
    
    private func setupUIBindings() {
        //subscribe on datasource changing from model and reload UICollectionView
        //I didn't use Driver<>, because I'd like to get forwarded errors and display
        //them in AlertView
        model.movies
            .observeOn(MainScheduler.instance)
            .subscribe( onNext: { [unowned self] (movies) in
                    self.movies = movies
                    self.collectionView.reloadData()
                }, onError: { [unowned self] (error) in
                    self.showAlert(with: error.localizedDescription)
                })
            .disposed(by: disposeBag)
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error".localized, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok".localized, style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}


// This extension provides the only one single valid way to initiate MoviesListViewController
// instance and inject all dependencies
extension MoviesListViewController {
    static func create(withViewModel model: MoviesListViewModel) -> MoviesListViewController {
        let vc = MoviesListViewController.instantiateFromStoryboard(storyboardName: StoryBoardName.main, storyboardId: "MoviesListViewController")
        vc.model = model
        return vc
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Display Movie cell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell {
            let movie = movies[indexPath.row]
            let model = MovieCellViewModel(movie: movie)
            cell.apply(model: model)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //Add search bar inside header section
        switch kind {
        case UICollectionElementKindSectionHeader:
            if let searchBar = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier:
                SearchBarView.identifier, for: indexPath) as? SearchBarView {
                
                //get suggestions list from persistent store and use them for suggestions view
                searchBar.use(suggestions: model.suggestions())
                
                //this code combines tap on "search" button and the last text in search bar
                //after that starts new fetch request in model
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //lazy pagination support. Model could fetch next page if it is possible
        model.displayedItem.value = indexPath.row
    }
}


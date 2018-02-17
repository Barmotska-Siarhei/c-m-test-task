//
//  MoviesListViewController.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
  
    private var arr = [Int](0...20)
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell {
            
            cell.nameLabel.text = "row \(arr[indexPath.row])"
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SearchBarView.identifier, for: indexPath)
            
        default:
            break
        }
        
        return UICollectionReusableView()
    }
    
}


extension MoviesListViewController: UICollectionViewDelegate {
    
}


extension MoviesListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            collectionView.reloadData()
        }
    }
    
}


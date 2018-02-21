//
//  SearchBarView.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 *  Subclass of UICollectionReusableView contains UISearchBar control and
 *  is displayed inside section header of UICollectionView
 *  After the focus getting into search bar, the suggestion list is shown,
 *  this list hides, when focus is lost. List of suggestions is standard
 *  array and is set outside of this class.
 */

class SearchBarView: UICollectionReusableView {
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate lazy var suggestionsView = SuggestionsListView(frame: .zero)
    fileprivate var suggestions: [String]?
    fileprivate var suggestionsViewHeight: Float = 200
    fileprivate let disposeBag = DisposeBag()
  
    static let identifier = "SearchBarView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //Single public method applies suggestions list for next displaying
    func use(suggestions: [String]?) {
        self.suggestions = suggestions
    }
    
    //MARK: - Private
    
    private func setupUI() {
        setupBind()
    }
    
    private func setupBind() {
        //when user starts a typing just update displayed items in suggestions view
        searchBar.rx.textDidBeginEditing.asObservable()
            .map{[unowned self] in
                return self.suggestions ?? []
            }
            .bind(to: self.suggestionsView.items)
            .disposed(by: disposeBag)
        
        //and also display this suggestions view on screen
        searchBar.rx.textDidBeginEditing.asObservable()
            .subscribe(onNext: {[unowned self] in
                self.window?.addSubview(self.suggestionsView)
                self.expandSuggestionsView()
            })
            .disposed(by: disposeBag)
        
        //when user ends a typing (search bar lost a focus) just remove suggestions view
        //from screen
        searchBar.rx.textDidEndEditing.asObservable()
            .subscribe(onNext: {[unowned self] in
                self.suggestionsView.removeFromSuperview()
            })
            .disposed(by: disposeBag)
        
        //selected item from suggestions view is transmitted to search bar
        suggestionsView.didSelectedItem
            .bind(to: self.searchBar.rx.text)
            .disposed(by: disposeBag)
        
        suggestionsView.didSelectedItem.asObservable()
            .subscribe(onNext: {[unowned self] (_) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.suggestionsView.alpha = 0
                }, completion: { _ in
                    self.suggestionsView.removeFromSuperview()
                    self.suggestionsView.alpha = 1
                })
            })
            .disposed(by: disposeBag)
        
        /*This workaround helps to simalute autolayout behaviour:
          SearchBarView instance is placed on collection view header
          SuggestionsListView instance is placed in UIWindow
          So they can't be related via NSLayoutConstraint or NSLayoutAnchor
          Approach is easy: we recalculate SuggestionsListView position after
          change of "width" value of SearchBarView instance
        */
        self.rx.observe(CGRect.self, "bounds")
            .map{$0?.size.width ?? 0}
            .subscribe(onNext: {[unowned self] (width) in
                self.adjustSuggestionsViewFrame()
        })
        .disposed(by: disposeBag)
    }
    
}

extension SearchBarView {
    
    fileprivate func adjustSuggestionsViewFrame() {
        //place suggestions view under search bar and set the same width
        var rect = suggestionsView.frame
        let searchRect = self.window?.convert(self.frame, from: self.superview) ?? .zero
        rect.size.width = searchRect.size.width
        rect.size.height = CGFloat(self.suggestionsViewHeight)
        rect.origin.x = 0
        rect.origin.y = searchRect.origin.y + searchRect.size.height
        suggestionsView.frame = rect
    }
    
    fileprivate func expandSuggestionsView() {
        adjustSuggestionsViewFrame()
        
        //collapse before expanding
        var rect = suggestionsView.frame
        rect.size.height = 0
        self.suggestionsView.frame = rect
        
        //expand suggestions view
        rect.size.height = CGFloat(self.suggestionsViewHeight)
        rect.size.height = CGFloat(self.suggestionsViewHeight)
        UIView.animate(withDuration: 0.2, animations: {
            self.suggestionsView.frame = rect
        }, completion: nil)
    }
}

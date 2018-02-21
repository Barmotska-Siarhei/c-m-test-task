//
//  MoviesListViewModel.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MoviesListViewModel {
    var filmName = PublishSubject<String?>()
    var displayedItem = Variable<Int>(0)
    var movies:Driver<[Movie]> {return self.moviesArray.asDriver()}
    
    private var pageNumber = Variable<Int>(1)
    private var fetchedPageNumber = Variable<Int>(0)
    private var totalPages = Variable<Int>(0)
    private var totalMovies = Variable<Int>(0)
    
    private var fetchAPI: FetchRequester
    private var persistentStore: AnyPersistentProvider<String>
    private let disposeBag = DisposeBag()
    private var moviesArray = Variable<[Movie]>([])
 
    init (fetchAPI: FetchRequester, persistentStore: AnyPersistentProvider<String>) {
        self.fetchAPI = fetchAPI
        self.persistentStore = persistentStore
    }
    
    func startMovieFetcherDaemon() {
        
        let newMovieFetch = filmName.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .map{ $0 ?? "" }
            .filter{ $0 != ""}
            .distinctUntilChanged()
            .share(replay: 1)
        
        newMovieFetch.subscribe(onNext: {[unowned self]  (_) in
                self.moviesArray.value = []
                self.totalPages.value = 0
                self.totalMovies.value = 0
                self.pageNumber.value = 1
            })
            .disposed(by: disposeBag)
        
        // New fetch (combination Name + Page)
        Observable
            .combineLatest(newMovieFetch, pageNumber.asObservable()) {
                (name:$0, number:$1)
            }
            .flatMapLatest { [unowned self] (pair) in
                self.fetchAPI.fetchMoviesList(by: pair.name, on: pair.number)
            }
            .subscribe(onNext: {[unowned self] (result) in
                let name = result.request
                let response = result.response
                
                if self.moviesArray.value.count == 0 {
                    //this successful request should be saved in persistent store
                    //for next usage as suggestion
                    self.persistentStore.save(object: name)
                }
                
                self.totalPages.value = response.totalPages
                self.totalMovies.value = response.totalResults
                self.moviesArray.value += response.movies
            })
            .disposed(by: disposeBag)
        
        // Pagination support (fetch new page if last fetched item is shown)
        displayedItem.asObservable()
            .distinctUntilChanged()
            .filter{ $0 == self.moviesArray.value.count - 1}
            .subscribe(onNext: {[unowned self] (row) in
                if self.pageNumber.value < self.totalPages.value {
                    self.pageNumber.value += 1
                }
            })
            .disposed(by: disposeBag)
    }
    
    func suggestions() -> [String] {
        return persistentStore.allObjects()
    }
}

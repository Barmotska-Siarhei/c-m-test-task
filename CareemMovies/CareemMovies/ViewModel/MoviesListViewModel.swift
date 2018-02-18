//
//  MoviesListViewModel.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 17.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import Foundation
import RxSwift

class MoviesListViewModel {
    var filmName = PublishSubject<String?>()
    var pageNumber = Variable<Int>(1)
    var movies:Observable<[Movie]> {return self.moviesArray.asObservable()}
    
    private var fetchAPI: FetchRequester
    private let disposeBag = DisposeBag()
    private var moviesArray = PublishSubject<[Movie]>()
    
 
    init (fetchAPI: FetchRequester) {
        self.fetchAPI = fetchAPI
    }
    
    func startMovieFetchDaemon() {
        
        filmName.asObservable()
        .throttle(0.5, scheduler: MainScheduler.instance)
        .map{ $0 ?? "" }
        .filter{ $0 != ""}
        .distinctUntilChanged()
        .flatMapLatest({(name) in
            Observable<[Movie]>.create({[unowned self] (observer) -> Disposable in
                let _ = self.fetchAPI.set(onCompleted: { (result) in
                    switch result {
                    case .data(let response):
                        observer.onNext(response.movies)
                    case .error(let error):
                        //observer.onError(Error())
                        break
                    }
                })
                self.fetchAPI.fetchMoviesList(by: name, on: self.pageNumber.value)
                return Disposables.create()
            })
        })
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {[unowned self] (movies) in
            self.moviesArray.onNext(movies)
         })
        .disposed(by: disposeBag)
    }
}

//
//  SuggestionsListView.swift
//  CareemMovies
//
//  Created by Siarhei Barmotska on 21.02.18.
//  Copyright © 2018 Siarhei Barmotska. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SuggestionsListView: UIView {
    var items = Variable<[String]>([])
    
    private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let reuseIdentifier = "SuggestioCell"
    
    var didSelectedItem = PublishSubject<String>()
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    //MARK: - Private
    
    private func setupUI() {
        tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = 30
        addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        setupBinds()
    }
    
     private func setupBinds() {
        //bind datasource and and
        items.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: UITableViewCell.self)) {
                row, text, cell in
                cell.textLabel?.text = text
            }
            .disposed(by: disposeBag)
        
        //didSelect event binding
        tableView.rx.modelSelected(String.self)
            .bind(to: self.didSelectedItem)
            .disposed(by: disposeBag)
        
    }
}



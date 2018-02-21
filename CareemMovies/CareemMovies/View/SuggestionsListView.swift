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

/**
 *  Class purpose is displayng of list of string inside UITableView
 *  Possible application is suggestions view. Usage of RxSwift allows
 *  the management of data source outside this class. All changes in data
 *  source are affected immediately to cell contents. Selected ited is known
 *  outside class over "didSelectedItem" observeble.
 */

class SuggestionsListView: UIView {
    //main data source for TableView. Could be modified any time
    var items = Variable<[String]>([])
    
    //keep selected item of UITableView and could be observed outside
    var didSelectedItem = PublishSubject<String>()
    
    private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let reuseIdentifier = "SuggestioCell"
    
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
        //table view occupies full area of view
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
        //bind datasource and and render table view cell
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

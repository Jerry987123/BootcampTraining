//
//  SearchingViewController.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/21.
//

import UIKit
import RxSwift

class SearchingViewController: UIViewController {

    var _tableView:UITableView?
    var _searchController:UISearchController?

    let viewModel = SearchingViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSearchController()
        viewModel.musicDatas.asObservable().subscribe { _ in
            self._tableView?.reloadData()
        }.disposed(by: disposeBag)
        viewModel.movieDatas.asObservable().subscribe { _ in
            self._tableView?.reloadData()
        }.disposed(by: disposeBag)
    }
}


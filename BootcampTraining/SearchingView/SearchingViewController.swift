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
    var _loadingIndicator:UIActivityIndicatorView?

    let viewModel = SearchingViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSearchController()
        setLoadingIndicator()
        viewModel.movieDatas.subscribe { _ in
            self._tableView?.reloadData()
        } onError: { error in
            if let error = error as? CustomError {
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
        viewModel.musicDatas.subscribe { _ in
            self._tableView?.reloadData()
        } onError: { error in
            if let error = error as? CustomError {
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    override func viewWillDisappear(_ animated: Bool) {
        if _searchController?.isActive ?? false {
            _searchController?.isActive = false
        }
    }
}


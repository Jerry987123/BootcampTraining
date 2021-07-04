//
//  SearchingViewController.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/21.
//

import UIKit
import RxSwift

class SearchingViewController: UIViewController {

    lazy var tableView = UITableView()
    var _searchController:UISearchController?
    var _loadingIndicator:UIActivityIndicatorView?
    var movieDatas = [iTunesSearchAPIResponseResult]()
    var musicDatas = [iTunesSearchAPIResponseResult]()
    
    let viewModel = SearchingViewModel()
    let collectionViewModel = CollectionViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSearchController()
        setLoadingIndicator()
        viewModel.movieObservable.subscribe { [weak self] event in
            if let result = event.element {
                switch result {
                case .success(let datas):
                    if let datas = datas as? [iTunesSearchAPIResponseResult] {
                        self?.movieDatas = datas
                    }
                case .failure(let error):
                    self?.alertWhenError(msg: error.localizedDescription)
                }
            }
        }.disposed(by: disposeBag)
        viewModel.musicObservable.subscribe { [weak self] event in
            if let result = event.element {
                switch result {
                case .success(let datas):
                    if let datas = datas as? [iTunesSearchAPIResponseResult] {
                        self?.musicDatas = datas
                    }
                case .failure(let error):
                    self?.alertWhenError(msg: error.localizedDescription)
                }
            }
        }.disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if _searchController?.isActive ?? false {
            _searchController?.isActive = false
        }
    }
}


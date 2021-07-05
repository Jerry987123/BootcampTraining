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
    var searchController = UISearchController()
    var loadingIndicator = UIActivityIndicatorView()
    var movieData = [iTunesSearchAPIResponseResult]()
    var musicData = [iTunesSearchAPIResponseResult]()
    
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
                case .success(let data):
                    if let data = data as? [iTunesSearchAPIResponseResult] {
                        self?.movieData = data
                    }
                case .failure(let error):
                    self?.alertWhenError(msg: error.localizedDescription)
                }
            }
        }.disposed(by: disposeBag)
        viewModel.musicObservable.subscribe { [weak self] event in
            if let result = event.element {
                switch result {
                case .success(let data):
                    if let data = data as? [iTunesSearchAPIResponseResult] {
                        self?.musicData = data
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
        super.viewWillDisappear(animated)
        if searchController.isActive {
            searchController.isActive = false
        }
    }
}


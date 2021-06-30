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
                self.alertWhenAPIError(msg: error.localizedDescription)
            }
        }.disposed(by: disposeBag)
        viewModel.musicDatas.subscribe { _ in
            self._tableView?.reloadData()
        } onError: { error in
            if let error = error as? CustomError {
                self.alertWhenAPIError(msg: error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _tableView?.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if _searchController?.isActive ?? false {
            _searchController?.isActive = false
        }
    }
    private func alertWhenAPIError(msg:String){
        _searchController?.isActive = false
        let alert = UIAlertController(title: "系統異常", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}


//
//  SearchingViewControllerExt.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import UIKit

extension SearchingViewController {
    func setTableView(){
        if _tableView == nil {
            _tableView = UITableView()
        }
        guard let tableView = _tableView else {
            return print("tableView failed to init.")
        }
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func setSearchController(){
        if _searchController == nil {
            _searchController = UISearchController()
            guard let searchController = _searchController else {
                return print("searchController failed to init")
            }
            searchController.searchResultsUpdater = self
            searchController.searchBar.delegate = self
            searchController.searchBar.placeholder = "搜尋"
            if let tableView = _tableView {
                tableView.tableHeaderView = searchController.searchBar
            }
            
        }
    }
}

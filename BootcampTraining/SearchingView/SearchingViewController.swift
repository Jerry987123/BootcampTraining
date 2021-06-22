//
//  SearchingViewController.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/21.
//

import UIKit

class SearchingViewController: UIViewController {

    var _tableView:UITableView?
    var _searchController:UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSearchController()
    }


}


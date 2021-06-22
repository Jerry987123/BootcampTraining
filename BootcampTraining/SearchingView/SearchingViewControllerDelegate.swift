//
//  SearchingViewControllerDelegate.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import UIKit

extension SearchingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var result = ""
        switch section {
        case 0:
            result = "電影"
        case 1:
            result = "音樂"
        default:
            result = "其它"
        }
        return result
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = Bundle.main.loadNibNamed("MovieCell", owner: self, options: nil)?.first as! MovieCell
            return cell
        case 1:
            let cell = Bundle.main.loadNibNamed("MusicCell", owner: self, options: nil)?.first as! MusicCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}
extension SearchingViewController: UITableViewDelegate {
    
}
extension SearchingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            print("執行搜尋關鍵字=\(searchText)")
        }
    }
}
extension SearchingViewController: UISearchBarDelegate {

}

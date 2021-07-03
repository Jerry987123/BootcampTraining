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
            return movieDatas.count
        case 1:
            return musicDatas.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.setCell(model: movieDatas[indexPath.row])
            cell.expandCell = { [weak self] sender in
                self?.viewModel.appendExpandCellIndex(index: indexPath.row)
                self?._tableView?.beginUpdates()
                cell.setExpandCell()
                self?._tableView?.endUpdates()
            }
            cell.narrowCell = { [weak self] sender in
                self?.viewModel.removeExpandCellIndex(index: indexPath.row)
                self?._tableView?.beginUpdates()
                cell.setNarrowCell()
                self?._tableView?.endUpdates()
            }
            if viewModel.movicExpandCellIndex.contains(indexPath.row){
                cell.setExpandCell()
            } else {
                cell.setNarrowCell()
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
            cell.setCell(model: musicDatas[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}
extension SearchingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var trackViewUrl = ""
        switch indexPath.section {
        case 0:
            trackViewUrl = movieDatas[indexPath.row].trackViewUrl
        case 1:
            trackViewUrl = musicDatas[indexPath.row].trackViewUrl
        default:
            return
        }
        if let url = URL(string: trackViewUrl), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
extension SearchingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text,
           searchText.trimmingCharacters(in: .whitespaces).count > 0 {
            _loadingIndicator?.startAnimating()
            viewModel.updatedByAPI(term: searchText) { [weak self] in
                self?._loadingIndicator?.stopAnimating()
            }
        }
    }
}

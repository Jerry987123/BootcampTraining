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
            let datas = try? viewModel.movieDatas.value()
            return datas?.count ?? 0
        case 1:
            let datas = try? viewModel.musicDatas.value()
            return datas?.count ?? 0
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            if let datas = try? viewModel.movieDatas.value(){
                cell.setCell(model: datas[indexPath.row])
            }
            cell.expandCell = { sender in
                self.viewModel.appendExpandCellIndex(index: indexPath.row)
                tableView.beginUpdates()
                cell.longDescriptionLabel.numberOfLines = 0
                sender.setTitle("...read less", for: .normal)
                tableView.endUpdates()
            }
            cell.narrowCell = { sender in
                self.viewModel.removeExpandCellIndex(index: indexPath.row)
                tableView.beginUpdates()
                cell.longDescriptionLabel.numberOfLines = 2
                sender.setTitle("...read more", for: .normal)
                tableView.endUpdates()
            }
            if viewModel.movicExpandCellIndex.contains(indexPath.row){
                cell.longDescriptionLabel.numberOfLines = 0
            } else {
                cell.longDescriptionLabel.numberOfLines = 2
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
            if let datas = try? viewModel.musicDatas.value(){
                cell.setCell(model: datas[indexPath.row])
            }
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
            if let datas = try? viewModel.movieDatas.value(){
                trackViewUrl = datas[indexPath.row].trackViewUrl
            }
        case 1:
            if let datas = try? viewModel.musicDatas.value(){
                trackViewUrl = datas[indexPath.row].trackViewUrl
            }
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
            viewModel.updatedByAPI(term: searchText) {
                self._loadingIndicator?.stopAnimating()
            }
        }
    }
}

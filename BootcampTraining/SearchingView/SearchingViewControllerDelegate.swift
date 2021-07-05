//
//  SearchingViewControllerDelegate.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import UIKit

extension SearchingViewController: CollectingActionDelegateInCell {
    func collectionDBInsertOrDelete(model: iTunesSearchAPIResponseResult, collectingAction: CollectingActionIndex, mediaType:SearchingMediaType) {
        let result = collectionViewModel.collectionDBInsertOrDelete(model: model, collectingAction: collectingAction, mediaType: mediaType)
        switch result {
        case .success:
            break
        case .failure(let error):
            alertWhenError(msg: error.localizedDescription)
        }
    }
}
extension SearchingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.searchingType.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var result = ""
        switch section {
        case 0:
            result = viewModel.searchingType[0]
        case 1:
            result = viewModel.searchingType[1]
        default:
            result = "其它"
        }
        return result
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return movieData.count
        case 1:
            return musicData.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.setCell(model: movieData[indexPath.row])
            cell.expandCell = { [weak self] sender in
                self?.viewModel.appendExpandCellIndex(index: indexPath.row)
                self?.tableView.beginUpdates()
                cell.setExpandCell()
                self?.tableView.endUpdates()
            }
            cell.narrowCell = { [weak self] sender in
                self?.viewModel.removeExpandCellIndex(index: indexPath.row)
                self?.tableView.beginUpdates()
                cell.setNarrowCell()
                self?.tableView.endUpdates()
            }
            if let trackId = movieData[indexPath.row].trackId {
                let alreadyAdded = viewModel.alreadyAddedInDB(trackId: Int(truncating: trackId))
                cell.adjustCollectionButtonName(alreadyAdded: alreadyAdded)
            } else {
                cell.adjustCollectionButtonName(alreadyAdded: false)
            }
            cell.collectingActionDelegate = self
            if viewModel.movicExpandCellIndex.contains(indexPath.row){
                cell.setExpandCell()
            } else {
                cell.setNarrowCell()
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
            cell.setCell(model: musicData[indexPath.row])
            if let trackId = musicData[indexPath.row].trackId {
                let alreadyAdded = viewModel.alreadyAddedInDB(trackId: Int(truncating: trackId))
                cell.adjustCollectionButtonName(alreadyAdded: alreadyAdded)
            } else {
                cell.adjustCollectionButtonName(alreadyAdded: false)
            }
            cell.collectingActionDelegate = self
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
            trackViewUrl = movieData[indexPath.row].trackViewUrl
        case 1:
            trackViewUrl = musicData[indexPath.row].trackViewUrl
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
                self?.tableView.reloadData()
            }
        }
    }
}

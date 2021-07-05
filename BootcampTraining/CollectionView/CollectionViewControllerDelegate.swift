//
//  CollectionViewControllerDelegate.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/30.
//

protocol CollectingActionDelegateInCell: AnyObject {
    func collectionDBInsertOrDelete(model:iTunesSearchAPIResponseResult, collectingAction:CollectingActionIndex, mediaType:SearchingMediaType)
}
extension CollectionViewController: CollectingActionDelegateInCell {
    func collectionDBInsertOrDelete(model: iTunesSearchAPIResponseResult, collectingAction: CollectingActionIndex, mediaType:SearchingMediaType) {
        let result = viewModel.collectionDBInsertOrDelete(model: model, collectingAction: collectingAction, mediaType: mediaType)
        switch result {
        case .success:
            break
        case .failure(let error):
            alertWhenError(msg: error.localizedDescription)
        }
    }
}
extension CollectionViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch switchButtonView.selectedSegmentIndex {
        case 0:
            return movieTableData.count
        case 1:
            return musicTableData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch switchButtonView.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.setCell(model: movieTableData[indexPath.row])
            cell.expandCell = { [weak self] trackId in
                self?.viewModel.appendExpandCellIndex(index: trackId)
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            }
            cell.narrowCell = { [weak self] trackId in
                self?.viewModel.removeExpandCellIndex(index: trackId)
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            }
            cell.updateCellWhenRemoveFromCollectionView = { [weak self] trackId in
                guard let cellIndex = self?.viewModel.getTableDataIndex(trackId: trackId, data: self?.movieTableData ?? []) else {
                    return print("failed to get cellIndex")
                }
                self?.movieTableData.remove(at: cellIndex)
                self?.tableView.deleteRows(at: [IndexPath(row: cellIndex, section: 0)], with: .automatic)
            }
            if let trackId = movieTableData[indexPath.row].trackId {
                let alreadyAdded = viewModel.alreadyAddedInDB(trackId: Int(truncating: trackId))
                cell.adjustCollectionButtonName(alreadyAdded: alreadyAdded)
            } else {
                cell.adjustCollectionButtonName(alreadyAdded: false)
            }
            cell.collectingActionDelegate = self
            if viewModel.movicExpandCellIndex.contains(Int(truncating: movieTableData[indexPath.row].trackId ?? 0)){
                cell.setExpandCell()
            } else {
                cell.setNarrowCell()
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
            cell.setCell(model: musicTableData[indexPath.row])
            cell.updateCell = { [weak self] trackId in
                guard let cellIndex = self?.viewModel.getTableDataIndex(trackId: trackId, data: self?.musicTableData ?? []) else {
                    return print("failed to get cellIndex")
                }
                self?.musicTableData.remove(at: cellIndex)
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: [IndexPath(row: cellIndex, section: 0)], with: .automatic)
                self?.tableView.endUpdates()
            }
            if let trackId = musicTableData[indexPath.row].trackId {
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
extension CollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var trackViewUrl = ""
        switch switchButtonView.selectedSegmentIndex {
        case 0:
            trackViewUrl = movieTableData[indexPath.row].trackViewUrl
        case 1:
            trackViewUrl = musicTableData[indexPath.row].trackViewUrl
        default:
            return
        }
        if let url = URL(string: trackViewUrl), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

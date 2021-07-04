//
//  CollectionViewControllerDelegate.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/30.
//

protocol CollectingActionDelegateInCell {
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
            return movieTableDatas.count
        case 1:
            return musicTableDatas.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch switchButtonView.selectedSegmentIndex {
        case 0:
            let cell = Bundle.main.loadNibNamed("MovieCell", owner: self, options: nil)?.first as! MovieCell
            cell.setCell(model: movieTableDatas[indexPath.row])
            cell.expandCell = { [weak self] sender in
                guard let cell = sender.superview?.superview as? MovieCell else {
                    return print("cell error")
                }
                guard let cellIndexPath = self?.tableView.indexPath(for: cell) else {
                    return print("cellIndexPath error")
                }
                self?.viewModel.appendExpandCellIndex(index: Int(truncating: self?.movieTableDatas[cellIndexPath.row].trackId ?? 0))
                self?.tableView.beginUpdates()
                cell.setExpandCell()
                self?.tableView.endUpdates()
            }
            cell.narrowCell = { [weak self] sender in
                guard let cell = sender.superview?.superview as? MovieCell else {
                    return print("cell error")
                }
                guard let cellIndexPath = self?.tableView.indexPath(for: cell) else {
                    return print("cellIndexPath error")
                }
                self?.viewModel.removeExpandCellIndex(index: Int(truncating: self?.movieTableDatas[cellIndexPath.row].trackId ?? 0))
                self?.tableView.beginUpdates()
                cell.setNarrowCell()
                self?.tableView.endUpdates()
            }
            cell.updateCellWhenRemoveFromCollectionView = { [weak self] sender in
                guard let cell = sender.superview?.superview as? MovieCell else {
                    return print("cell error")
                }
                guard let cellIndexPath = self?.tableView.indexPath(for: cell) else {
                    return print("cellIndexPath error")
                }
                self?.movieTableDatas.remove(at: cellIndexPath.row)
                self?.tableView.deleteRows(at: [cellIndexPath], with: .automatic)
            }
            cell.collectingActionDelegate = self
            if viewModel.movicExpandCellIndex.contains(Int(truncating: movieTableDatas[indexPath.row].trackId ?? 0)){
                cell.setExpandCell()
            } else {
                cell.setNarrowCell()
            }
            return cell
        case 1:
            let cell = Bundle.main.loadNibNamed("MusicCell", owner: self, options: nil)?.first as! MusicCell
            cell.setCell(model: musicTableDatas[indexPath.row])
            cell.updateCell = { [weak self] sender in
                guard let cell = sender.superview?.superview as? MusicCell else {
                    return print("cell error")
                }
                guard let cellIndexPath = self?.tableView.indexPath(for: cell) else {
                    return print("cellIndexPath error")
                }
                self?.musicTableDatas.remove(at: cellIndexPath.row)
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: [cellIndexPath], with: .automatic)
                self?.tableView.endUpdates()
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
            trackViewUrl = movieTableDatas[indexPath.row].trackViewUrl
        case 1:
            trackViewUrl = musicTableDatas[indexPath.row].trackViewUrl
        default:
            return
        }
        if let url = URL(string: trackViewUrl), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

//
//  CollectionViewControllerDelegate.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/30.
//

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
                guard let cellIndexPath = self?._tableView?.indexPath(for: cell) else {
                    return print("cellIndexPath error")
                }
                self?.viewModel.appendExpandCellIndex(index: Int(truncating: self?.movieTableDatas[cellIndexPath.row].trackId ?? 0))
                self?._tableView?.beginUpdates()
                cell.longDescriptionLabel.numberOfLines = 0
                sender.setTitle("...read less", for: .normal)
                self?._tableView?.endUpdates()
            }
            cell.narrowCell = { [weak self] sender in
                guard let cell = sender.superview?.superview as? MovieCell else {
                    return print("cell error")
                }
                guard let cellIndexPath = self?._tableView?.indexPath(for: cell) else {
                    return print("cellIndexPath error")
                }
                self?.viewModel.removeExpandCellIndex(index: Int(truncating: self?.movieTableDatas[cellIndexPath.row].trackId ?? 0))
                self?._tableView?.beginUpdates()
                cell.longDescriptionLabel.numberOfLines = 2
                sender.setTitle("...read more", for: .normal)
                self?._tableView?.endUpdates()
            }
            cell.updateCellWhenRemoveFromCollectionView = { [weak self] sender in
                guard let cell = sender.superview?.superview as? MovieCell else {
                    return print("cell error")
                }
                guard let cellIndexPath = self?._tableView?.indexPath(for: cell) else {
                    return print("cellIndexPath error")
                }
                self?.movieTableDatas.remove(at: cellIndexPath.row)
                self?._tableView?.deleteRows(at: [cellIndexPath], with: .automatic)
            }
            if viewModel.movicExpandCellIndex.contains(Int(truncating: movieTableDatas[indexPath.row].trackId ?? 0)){
                cell.longDescriptionLabel.numberOfLines = 0
            } else {
                cell.longDescriptionLabel.numberOfLines = 2
            }
            return cell
        case 1:
            let cell = Bundle.main.loadNibNamed("MusicCell", owner: self, options: nil)?.first as! MusicCell
            cell.setCell(model: musicTableDatas[indexPath.row])
            cell.updateCell = { [weak self] sender in
                guard let cell = sender.superview?.superview as? MusicCell else {
                    return print("cell error")
                }
                guard let cellIndexPath = self?._tableView?.indexPath(for: cell) else {
                    return print("cellIndexPath error")
                }
                self?.musicTableDatas.remove(at: cellIndexPath.row)
                self?._tableView?.beginUpdates()
                self?._tableView?.deleteRows(at: [indexPath], with: .automatic)
                self?._tableView?.endUpdates()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
extension CollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var trackViewUrl = ""
        switch indexPath.section {
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

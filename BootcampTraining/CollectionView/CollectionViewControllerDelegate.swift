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
            cell.updateCell = { sender in
                self.movieTableDatas.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            if viewModel.movicExpandCellIndex.contains(indexPath.row){
                cell.longDescriptionLabel.numberOfLines = 0
            } else {
                cell.longDescriptionLabel.numberOfLines = 2
            }
            return cell
        case 1:
            let cell = Bundle.main.loadNibNamed("MusicCell", owner: self, options: nil)?.first as! MusicCell
            cell.setCell(model: musicTableDatas[indexPath.row])
            cell.updateCell = { sender in
                self.musicTableDatas.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
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

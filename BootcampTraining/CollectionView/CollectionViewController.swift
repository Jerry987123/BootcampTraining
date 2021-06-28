//
//  CollectionViewController.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/24.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var switchButtonView: UISegmentedControl!
    
    var _tableView:UITableView?
    
    let viewModel = CollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.loadCollectionFromDB(mediaType: .movie)
    }
    @IBAction func switchButtonAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("電影")
            viewModel.loadCollectionFromDB(mediaType: .movie)
        case 1:
            print("音樂")
            viewModel.loadCollectionFromDB(mediaType: .music)
        default:
            break
        }
        _tableView?.reloadData()
    }
    private func setUI(){
        title = "收藏項目"
        setTableView()
    }
    private func setTableView(){
        if _tableView == nil {
            _tableView = UITableView()
        }
        guard let tableView = _tableView else {
            return print("tableView failed to init.")
        }
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: switchButtonView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
extension CollectionViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch switchButtonView.selectedSegmentIndex {
        case 0:
            return viewModel.movieDatas.value.count
        case 1:
            return viewModel.musicDatas.value.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch switchButtonView.selectedSegmentIndex {
        case 0:
            let cell = Bundle.main.loadNibNamed("MovieCell", owner: self, options: nil)?.first as! MovieCell
            cell.setCell(model: viewModel.movieDatas.value[indexPath.row])
            cell._tableView = tableView
            return cell
        case 1:
            let cell = Bundle.main.loadNibNamed("MusicCell", owner: self, options: nil)?.first as! MusicCell
            cell.setCell(model: viewModel.musicDatas.value[indexPath.row])
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
            trackViewUrl = viewModel.movieDatas.value[indexPath.row].trackViewUrl
        case 1:
            trackViewUrl = viewModel.musicDatas.value[indexPath.row].trackViewUrl
        default:
            return
        }
        if let url = URL(string: trackViewUrl), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

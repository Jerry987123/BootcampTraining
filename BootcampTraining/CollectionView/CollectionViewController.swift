//
//  CollectionViewController.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/24.
//

import UIKit
import RxSwift

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var switchButtonView: UISegmentedControl!
    
    var _tableView:UITableView?
    
    let viewModel = CollectionViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.musicDatas.asObservable().subscribe { _ in
            self._tableView?.reloadData()
        }.disposed(by: disposeBag)
        viewModel.movieDatas.asObservable().subscribe { _ in
            self._tableView?.reloadData()
        }.disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch switchButtonView.selectedSegmentIndex {
        case 0:
            viewModel.loadCollectionFromDB(mediaType: .movie)
        case 1:
            viewModel.loadCollectionFromDB(mediaType: .music)
        default:
            break
        }
    }
    @IBAction func switchButtonAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.loadCollectionFromDB(mediaType: .movie)
        case 1:
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

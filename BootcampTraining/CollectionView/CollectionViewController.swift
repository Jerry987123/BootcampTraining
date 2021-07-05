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
    
    lazy var tableView = UITableView()
    var movieTableData = [iTunesSearchAPIResponseResult]()
    var musicTableData = [iTunesSearchAPIResponseResult]()
    
    let viewModel = CollectionViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.movieData.asObservable().subscribe { [weak self] event in
            if let data = event.element {
                // weak
                self?.movieTableData = data
            }
            // weak
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        viewModel.musicData.asObservable().subscribe { [weak self] event in
            if let data = event.element {
                self?.musicTableData = data
            }
            self?.tableView.reloadData()
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
        tableView.reloadData()
    }
    private func setUI(){
        title = "收藏項目"
        setTableView()
    }
    private func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: switchButtonView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func alertWhenError(msg:String){
        let alert = UIAlertController(title: "系統異常", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

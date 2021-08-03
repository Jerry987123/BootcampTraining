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
    
    lazy var movieTableView = UITableView()
    lazy var musicTableView = UITableView()
    var movieTableData = [iTunesSearchAPIResponseResult]()
    var musicTableData = [iTunesSearchAPIResponseResult]()
    
    let viewModel = CollectionViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.movieData.asObservable().subscribe { [weak self] event in
            if let data = event.element {
                self?.movieTableData = data
                self?.movieTableView.reloadData()
            }
            self?.movieTableView.isHidden = false
            self?.musicTableView.isHidden = true
        }.disposed(by: disposeBag)
        viewModel.musicData.asObservable().subscribe { [weak self] event in
            if let data = event.element {
                self?.musicTableData = data
                self?.musicTableView.reloadData()
            }
            self?.movieTableView.isHidden = true
            self?.musicTableView.isHidden = false
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
    }
    private func setUI(){
        title = "收藏項目"
        setTableView()
    }
    private func setTableView(){
        movieTableView.isHidden = false
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        movieTableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        view.addSubview(movieTableView)
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.topAnchor.constraint(equalTo: switchButtonView.bottomAnchor).isActive = true
        movieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        movieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        musicTableView.isHidden = true
        musicTableView.dataSource = self
        musicTableView.delegate = self
        musicTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        musicTableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        view.addSubview(musicTableView)
        musicTableView.translatesAutoresizingMaskIntoConstraints = false
        musicTableView.topAnchor.constraint(equalTo: switchButtonView.bottomAnchor).isActive = true
        musicTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        musicTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        musicTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func alertWhenError(msg:String){
        let alert = UIAlertController(title: "系統異常", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

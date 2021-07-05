//
//  TopicViewController.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/24.
//

import UIKit

class TopicViewController: UIViewController {
    
    lazy var tableView = UITableView()
    
    let viewModel = TopicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
    }
    private func setUI(){
        title = "主題顏色"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        setTopicColor()
    }
    private func setTopicColor(){
        navigationController?.navigationBar.backgroundColor = TopicInteractor.topicColor.tabbar
    }
    private func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
extension TopicViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.themes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
        cell.titleLabel.text = viewModel.themes[indexPath.row]
        if viewModel.getSelectedTopic().rawValue == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}
extension TopicViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewModel.setSelectedTopic(topicType: .deepColor)
        case 1:
            viewModel.setSelectedTopic(topicType: .lightColor)
        default:
            break
        }
        tableView.reloadData()
        if let tabBar = tabBarController as? MainTabBarViewController {
            TopicInteractor.readTopicListFile()
            tabBar.setTopicColor()
        }
        setTopicColor()
    }
}

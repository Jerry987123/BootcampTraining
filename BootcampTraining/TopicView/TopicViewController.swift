//
//  TopicViewController.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/24.
//

import UIKit

class TopicViewController: UIViewController {
    
    var _tableView:UITableView?
    var datas = ["深色主題", "淺色主題"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
    }
    private func setUI(){
        title = "主題顏色"
    }
    private func setTableView(){
        if _tableView == nil {
            _tableView = UITableView()
        }
        guard let tableView = _tableView else {
            return print("tableView failed to init.")
        }
        tableView.delegate = self
        tableView.dataSource = self
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
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TopicCell", owner: self, options: nil)?.first as! TopicCell
        cell.titleLabel.text = datas[indexPath.row]
        return cell
    }
}
extension TopicViewController:UITableViewDelegate {
}

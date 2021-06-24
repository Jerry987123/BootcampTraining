//
//  PersonalViewController.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/21.
//

import UIKit

class PersonalViewController:UIViewController {
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var collectionNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func topicButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "TopicView", bundle: nil).instantiateViewController(withIdentifier: "TopicViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func collectionButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "CollectionView", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func aboutItunesButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "AboutiTunes", bundle: nil).instantiateViewController(withIdentifier: "AboutiTunesViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUI(){
        navigationController?.navigationBar.topItem?.title = "個人資料"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = TopicInteractor.topicColor.tabbar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
        let viewModel = TopicViewModel()
        let topicType = viewModel.getSelectedTopic()
        switch topicType {
        case .deepColor:
            topicLabel.text = viewModel.datas[0]
        case .lightColor:
            topicLabel.text = viewModel.datas[1]
        }
        
    }
}

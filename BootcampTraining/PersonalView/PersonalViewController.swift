//
//  PersonalViewController.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/21.
//

import UIKit

class PersonalViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func topicButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "TopicView", bundle: nil).instantiateViewController(withIdentifier: "TopicViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUI(){
        navigationController?.navigationBar.topItem?.title = "個人資料"
        navigationController?.navigationBar.backgroundColor = .gray
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
    }
}

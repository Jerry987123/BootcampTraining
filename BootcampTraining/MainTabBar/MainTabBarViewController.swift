//
//  MainTabBarViewController.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
        let searchingView = UIStoryboard(name: "SearchingView", bundle: nil).instantiateViewController(withIdentifier: "SearchingViewController")
        searchingView.tabBarItem.image = UIImage.init(systemName: "magnifyingglass")
        let personalView = UIStoryboard(name: "PersonalView", bundle: nil).instantiateViewController(withIdentifier: "PersonalViewController")
        personalView.tabBarItem.image = UIImage.init(systemName: "person")
        viewControllers = [searchingView, personalView]
    }
}

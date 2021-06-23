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
    private func setUI(){
        let searchingView = UIStoryboard(name: "SearchingView", bundle: nil).instantiateViewController(withIdentifier: "SearchingViewController")
        if #available(iOS 13.0, *) {
            searchingView.tabBarItem.image = UIImage.init(systemName: "magnifyingglass")
        } else {
            // Fallback on earlier versions
        }
        let personalView = UIStoryboard(name: "PersonalView", bundle: nil).instantiateViewController(withIdentifier: "PersonalViewController")
        if #available(iOS 13.0, *) {
            personalView.tabBarItem.image = UIImage.init(systemName: "person")
        } else {
            // Fallback on earlier versions
        }
        viewControllers = [searchingView, personalView]
        
        tabBar.backgroundColor = .gray
        let singleTabWidth: CGFloat = tabBar.frame.size.width / 2
        let singleTabSize = CGSize(width:singleTabWidth , height: tabBar.frame.size.height)
        let selectedTabBackgroundImage = imageWithColor(color: .white, size: singleTabSize)
        tabBar.selectionIndicatorImage = selectedTabBackgroundImage.resizableImage(withCapInsets: UIEdgeInsets(top: .leastNonzeroMagnitude, left: 0, bottom: 0, right: 0))
    }
    private func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context!.setFillColor(color.cgColor)
        context!.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}

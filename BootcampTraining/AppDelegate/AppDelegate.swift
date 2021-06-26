//
//  AppDelegate.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 載入主題顏色表
        TopicInteractor.readTopicListFile()
        // Set TabBarViewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarViewController()
        window?.makeKeyAndVisible()
        
        // 測試用 DB路徑
        print(NSHomeDirectory())
        return true
    }
}


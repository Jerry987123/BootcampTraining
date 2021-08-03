//
//  AboutiTunesViewController.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/24.
//

import UIKit
import WebKit

class AboutiTunesViewController: UIViewController {
    
    lazy var webView:WKWebView = WKWebView()
    
    let urlString = "https://support.apple.com/itunes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
        loadWebView()
    }
    private func setWebView(){
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    private func loadWebView(){
        if let url = URL(string: urlString){
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
}

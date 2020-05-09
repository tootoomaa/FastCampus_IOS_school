//
//  ViewController.swift
//  200509_navigationController
//
//  Created by 김광수 on 2020/05/09.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationItem.title = "FirstVC"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let barButtonItem1 =  UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(pushViewController(_:)))
        let barButtonItem2 =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushViewController(_:)))
        navigationItem.rightBarButtonItems = [barButtonItem2,barButtonItem1]
    }
    
    @objc private func pushViewController(_ sender: Any) {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
//        show(secondVC, sender: sender)
    }
}


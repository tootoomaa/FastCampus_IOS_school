//
//  SecondViewController.swift
//  200509_navigationController
//
//  Created by 김광수 on 2020/05/09.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SecondVC"
        view.backgroundColor = .orange
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.popViewController(animated: true)
    }
}

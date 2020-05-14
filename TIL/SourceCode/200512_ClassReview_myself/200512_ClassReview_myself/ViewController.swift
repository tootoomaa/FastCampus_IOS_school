//
//  ViewController.swift
//  200512_ClassReview_myself
//
//  Created by 김광수 on 2020/05/12.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customView: CustomView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.backgroundColor = .green
        
    }
}


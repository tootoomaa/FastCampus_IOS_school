//
//  SecondViewController.swift
//  200507_StoryBoardWithsegue
//
//  Created by 김광수 on 2020/05/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var stringLabel: UILabel!

    var getFirstString:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        stringLabel.text = getFirstString
    }

}

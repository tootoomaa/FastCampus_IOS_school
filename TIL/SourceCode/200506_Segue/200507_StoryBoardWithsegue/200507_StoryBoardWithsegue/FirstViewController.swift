//
//  ViewController.swift
//  200507_StoryBoardWithsegue
//
//  Created by 김광수 on 2020/05/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var buttonString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func unwindToFirstViewController(_ unwindSegue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondVC = segue.destination as? SecondViewController else { return }
        secondVC.getFirstString = buttonString
    }
    
    @IBAction func TabButton(_ sender: UIButton) {
        
        guard let sendString = sender.currentTitle else { return }
        buttonString = sendString
    }
}




//
//  SecondViewController.swift
//  200507_MnualSegue
//
//  Created by 김광수 on 2020/05/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    
    var secondViewNumber:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLabel.text = String(secondViewNumber)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

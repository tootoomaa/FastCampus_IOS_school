//
//  SecondViewController.swift
//  200507_homework
//
//  Created by 김광수 on 2020/05/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var animalImageView: UIImageView!
    
    var getSelectedAnimal:String = ""
    var getAnimalNumber:Int = 0
    var plusButtonTabCount:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageName = "\(getSelectedAnimal).jpeg"
        if getSelectedAnimal != "" {
            print(imageName)
            animalImageView.image = UIImage(named: imageName)
        }
    }
    
    @IBAction func tapButtonAction(_ sender: UIButton) {
        plusButtonTabCount += 1
    }
    
}

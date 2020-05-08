//
//  ViewController.swift
//  200508_homewokr
//
//  Created by 김광수 on 2020/05/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private struct Key {
        static var animalImage:String = "UserImage"
        static var togle:String = "toggle"
    }
    
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalSwitch.isOn = UserDefaults.standard.object(forKey: Key.togle) as? Bool ?? false
        let animalPictureName = animalSwitch.isOn ? "cat.jpg" : "dog.jpg"
        animalImageView.image = UIImage(named: animalPictureName)

    }

    @IBAction func toggleSwtich(_ sender: Any) {
        
        let animalPictureName = animalSwitch.isOn ? "cat.jpg" : "dog.jpg" 
        animalImageView.image = UIImage(named: animalPictureName)
        print("saved Data \(animalSwitch.isOn)")
        UserDefaults.standard.set(animalSwitch.isOn, forKey: Key.togle)
    }
    
}


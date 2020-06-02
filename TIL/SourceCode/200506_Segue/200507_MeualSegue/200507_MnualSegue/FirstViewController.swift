//
//  ViewController.swift
//  200507_MnualSegue
//
//  Created by 김광수 on 2020/05/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    var number:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func perforn(_ sender : UIButton) {
        
        guard let title = sender.currentTitle else {return}
        if title == "PlusTen" {
            number += 10
        } else if title == "PlusOne" {
            number += 1
        } else {
            number += 0
        }
        print(number)
  
        if number < 40 {
            performSegue(withIdentifier: "Plus", sender: sender)
        }
//        if title == "PlusTen" && number < 40 {
//            performSegue(withIdentifier: "Plus", sender: sender)
//        } else if title == "PlusOne" && number < 40 {
//            performSegue(withIdentifier: "Plus", sender: sender)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondVC = segue.destination as? SecondViewController else { return }
        
        secondVC.secondViewNumber = number
    }
    
    @IBAction func unWindToFirstViewController(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
}


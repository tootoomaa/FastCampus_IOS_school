//
//  ViewController.swift
//  200512_customView
//
//  Created by 김광수 on 2020/05/12.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    @IBOutlet weak var customView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        customView.backgroundColor = nil
    }
}

//MARK: - CustomViewDelegate
extension ViewController: CustomViewDelegate {
    func colorForBackground(_ newColor: UIColor?) -> UIColor {
        print("set colloer")
        guard let color = newColor else { return . gray }
        return color
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {return}
        switch text {
        case "red":
            customView.backgroundColor = .red
        case "blue":
            customView.backgroundColor = .blue
        case "orange":
            customView.backgroundColor = .orange
        default:
            customView.backgroundColor = .black
        }
    }
}

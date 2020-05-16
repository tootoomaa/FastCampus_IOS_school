//
//  ViewController.swift
//  homework_2005013
//
//  Created by 김광수 on 2020/05/13.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

protocol FirstToSecondDelegate: class {
    func sendText(_ text: String)
}

final class FirstVC: UIViewController {
    
    weak var delegate: FirstToSecondDelegate?
    @IBOutlet weak var textfield: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? SecondVC,
            let text = textfield.text,
            let identifier = segue.identifier
            else { return }
        
        switch identifier {
        case "DelegateA":
            delegate = dest
            delegate?.sendText(text)
        case "DelegateB":
            dest.delegate = self
        default: break
        }
    }
    
    @IBAction func unwindToFirstViewController(_ unwindSegue: UIStoryboardSegue) {
        guard let source = unwindSegue.source as? SecondVC else { return }
        source.delegate = nil
    }
}

// MARK: - SecondToFirstDelegate

extension FirstVC: SecondToFirstDelegate {
    func sendText() -> String {
        return textfield.text ?? ""
    }
}




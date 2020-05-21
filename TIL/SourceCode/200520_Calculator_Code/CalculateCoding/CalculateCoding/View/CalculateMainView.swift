//
//  ViewController.swift
//  CalculateCoding
//
//  Created by 김광수 on 2020/05/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CalculateMainView: UIViewController {
    
    
    //MARK: - Properties
    // button 크기 조절
    private struct ButtonSize {
        static var width:CGFloat = 80
    }
    
    private var displayString: String = "" {
        didSet {
            numberTextField.text = displayString
        }
    }
    
    let topCalculatorLabel: UILabel = {
        var label = UILabel()
        label.text = "Calculator"
        label.textColor = .white
        label.font = .systemFont(ofSize: 45)
        return label
    }()
    let numberTextField: UITextField = {
        var tf = UITextField()
        tf.textColor = .white
        tf.text = "0"
        tf.font = .systemFont(ofSize: 50)
        tf.textAlignment = .right
        return tf
    }()
    
    //MARK: - number View 1 Line
    let numberButton1: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("1", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let numberButton2: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("2", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let numberButton3: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("3", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let operandButtonPlus: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .orange
        bt.contentVerticalAlignment = .center
        bt.setTitle("+", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    
    //MARK: - number View 2 Line
    let numberButton4: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("4", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let numberButton5: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("5", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let numberButton6: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("6", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let operandButtonSub: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .orange
        bt.contentVerticalAlignment = .center
        bt.setTitle("−", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    
    //MARK: - number View 3 Line
    let numberButton7: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("7", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let numberButton8: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("8", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let numberButton9: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("9", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let operandButtonMul: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .orange
        bt.contentVerticalAlignment = .center
        bt.setTitle("×", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    
    //MARK: - number Veiw 4 Line
    let numberButton0: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .systemGray4
        bt.contentVerticalAlignment = .center
        bt.setTitle("0", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let operandButtonAC: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .orange
        bt.contentVerticalAlignment = .center
        bt.setTitle("AC", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let operandButtonEqu: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .orange
        bt.contentVerticalAlignment = .center
        bt.setTitle("=", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    let operandButtonDiv: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .orange
        bt.contentVerticalAlignment = .center
        bt.setTitle("÷", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 35)
        bt.layer.cornerRadius = ButtonSize.width / 2
        return bt
    }()
    
    //MARK: - Main View did Load()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //main View background Color
        view.backgroundColor = .gray
        
        topCalculatorLabel.frame = CGRect(x: view.frame.width/2-100, y: 40, width: 200, height: 40)
        view.addSubview(topCalculatorLabel)
        
        numberTextField.frame = CGRect(x: 20, y: 300, width: view.frame.size.width-40, height: 80)
        view.addSubview(numberTextField)
        
        
        //MARK: - Make Button StackView Layout
        
        //Define StackView
        let firstLineSTView = UIStackView(arrangedSubviews: [numberButton1,numberButton2, numberButton3, operandButtonPlus])
        let secondLineSTView = UIStackView(arrangedSubviews: [numberButton4,numberButton5, numberButton6, operandButtonSub])
        let thirdLineSTView = UIStackView(arrangedSubviews: [numberButton7,numberButton8, numberButton9, operandButtonMul])
        let fourthLineSTView = UIStackView(arrangedSubviews: [numberButton0,operandButtonAC, operandButtonEqu, operandButtonDiv])
        
        // Temp StackView Array
        let stackViewArray = [firstLineSTView,secondLineSTView,thirdLineSTView,fourthLineSTView]
        
        var beforeView = UIStackView()
        for i in stackViewArray {
            i.translatesAutoresizingMaskIntoConstraints = false
            i.axis = .horizontal
            i.spacing = 10.0
            i.distribution = .fillEqually
            
            view.addSubview(i)
            
            
            NSLayoutConstraint.activate([
                i.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                i.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                i.heightAnchor.constraint(equalToConstant: ButtonSize.width)
            ])
            
            if i == firstLineSTView {
                i.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 10).isActive = true
            } else {
                i.topAnchor.constraint(equalTo: beforeView.bottomAnchor, constant: 10).isActive = true
            }
            beforeView = i
        }
        
        //Temp Buttom Array
        let buttonArray = [numberButton1,numberButton2, numberButton3, operandButtonPlus,
                           numberButton4,numberButton5, numberButton6, operandButtonSub,
                           numberButton7,numberButton8, numberButton9, operandButtonMul,
                           numberButton0,operandButtonAC, operandButtonEqu, operandButtonDiv]
        
        for i in buttonArray {
            i.addTarget(self, action: #selector(tabButtonAction(_:)), for: .touchUpInside)
        }
    }
    
    @objc func tabButtonAction(_ sender:UIButton) {
        guard let inputButtonText = sender.currentTitle else {return}
        guard let currentDisplayString = numberTextField.text else {return}
        displayString = handleInputButtonText(inputButtonText,currentDisplayString)

    }

}


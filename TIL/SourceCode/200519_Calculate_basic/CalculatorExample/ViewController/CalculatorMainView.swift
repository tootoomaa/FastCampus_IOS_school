//
//  ViewController.swift
//  CalculatorExample
//
//  Created by giftbot on 2019/12/19.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class CalculatorMainView: UIViewController {
    
    @IBOutlet weak var mainTextLabel: UILabel!
    var userTypingCheck = false
    
    private struct operandStrunct {
        var numberLeft:Double = 0
        var numberRight:Double = 0
        var firstOper = ""
        var SecondOper = ""
    }
    private var saveData = operandStrunct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tabButtonAction(_ sender: UIButton) {
        guard let inputText = sender.currentTitle else {
            print("Button의 title을 가져오지 못했습니다.")
            return
        }
        
        if Double(inputText) == nil { // String형 변수 처리
            guard let getNumber = mainTextLabel.text else {
                print("mainTextLabel 에 데이터가 없습니다.")
                return
            }
            userTypingCheck = false // mainTextlabel 을 초기화 하기 위한 코드
            calculateCore(getNumber, inputText)
//            saveData.numberLeft = Double(getNumber)!
        } else {                    // Int형 변수 처리
            if !userTypingCheck {   // 처음 입력을 시작함
                mainTextLabel.text = inputText
                userTypingCheck = true
            } else {
                if inputText == "0" && mainTextLabel.text == "0"{
                } else if mainTextLabel.text == "0" {
                    mainTextLabel.text = inputText
                } else {
                    mainTextLabel.text! += inputText
                }
            }
        }
    }
    
    func initailizationSaveData() {
        saveData.firstOper = ""
        saveData.SecondOper = ""
        saveData.numberLeft = 0
        saveData.numberRight = 0
    }
    
    //MARK: - calculateCore
    func calculateCore(_ inputNumber:String,_ inputOperand: String ) {
        //AC 입력 받은 경우 모든사항 초기화
        if inputOperand == "AC" {
            print("초기화 실행")
            initailizationSaveData()
            mainTextLabel.text! = "0"
            return
        }
        // 첫번째 operand를 받앗을때 처리
        // 결과값 임시저장 변수
        var operandResult:Double = 0
        
        if saveData.firstOper == "" {
            if inputOperand == "=" {
                print("처음들어온 데이터가 = ")
                return
            }
            print("데이터가 처음 들어온 경우")
            saveData.numberLeft = Double(inputNumber)!
            saveData.firstOper = inputOperand
            print(saveData)
        } else if userTypingCheck == false && inputOperand != "=" {
            print("연산자만 바뀌는 경우 방지")
            print(saveData)
            saveData.firstOper = inputOperand
        } else { // 두번째 operand를 받았을때 처리
            //두번째 number 및 operand 저장
            print("데이터가 두번째 들어온 경우 // numberRight있음")
            print(saveData)
            saveData.numberRight = Double(inputNumber)!
            saveData.SecondOper = inputOperand
            switch saveData.firstOper {
            case "+":
                operandResult = saveData.numberLeft + saveData.numberRight
                saveData.numberLeft = operandResult
            case "-":
                operandResult = saveData.numberLeft - saveData.numberRight
                saveData.numberLeft = operandResult
            case "×":
                operandResult = saveData.numberLeft * saveData.numberRight
                saveData.numberLeft = operandResult
            case "÷":
                operandResult = saveData.numberLeft / saveData.numberRight
                saveData.numberLeft = operandResult
            case "=":
                operandResult = saveData.numberLeft
                initailizationSaveData()
                return
            default:
                print("Error")
            }
            print(operandResult)
            saveData.numberRight = 0
            saveData.firstOper = saveData.SecondOper
            saveData.SecondOper = ""
            mainTextLabel.text! = String(operandResult)
            print(saveData)
        }
    }
}

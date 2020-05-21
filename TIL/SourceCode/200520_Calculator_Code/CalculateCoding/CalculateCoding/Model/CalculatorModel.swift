//
//  CalculatorModel.swift
//  CalculateCoding
//
//  Created by 김광수 on 2020/05/21.
//  Copyright © 2020 김광수. All rights reserved.
//
import Foundation

//MARK: - Data Properties
var saveData = operandStruct()


//MARK: - Data Struct
struct operandStruct {
    var numberLeft:Double = 0.0
    var numberRight:Double = 0.0
    var firstOper = ""
    var SecondOper = ""
    
    mutating func initializationAll() {
        self.numberLeft = 0.0
        self.numberRight = 0.0
        self.firstOper = ""
        self.SecondOper = ""
    }
    
    mutating func getFisrtSet(_ numberLeft:Double, _ SeconOper:String) {
        self.numberLeft = numberLeft
        self.SecondOper = SeconOper
    }
    
    mutating func initailzationSecondValue() {
        self.numberRight = 0.0
        self.SecondOper = ""
    }
    
    mutating func SecondToFirstMoveData(_ numberRight:Double, _ secondOper:String) {
        self.numberLeft = numberRight
        self.firstOper = secondOper
    }
}

//MARK: - String Formatter
func StringFormat(_ number:Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal    // 천 단위로 콤마(,)
    formatter.maximumFractionDigits = 3    // 최대 소수점 단위
    return formatter.string(from: number as NSNumber)!
}


//MARK: - calculate Function

func newCalculaeCore(_ currentDisplayString:String,_ inputOperand: String, _ userTypingCheck:Bool) -> String {
    print(saveData)
    if inputOperand == "AC" {
        print("초기화 실행")
        saveData.initializationAll()
        return "0"
    }
    
    if saveData.firstOper == "" {                                  //데이터가 처음 들어온 경우
//        || (saveData.firstOper == "" && inputOperand == "=")        //첫 들어온게 '='
//        || (userTypingCheck == false && inputOperand != "=") {      //연산자만 바뀌는 경우 방지
//        print("데이터가 처음 들어온 경우 or 첫 들어온게 '=' or 연산자만 바뀌는 경우 방지")
        saveData.getFisrtSet(Double(currentDisplayString)!, inputOperand)
        return currentDisplayString
    }
    saveData.numberRight = Double(currentDisplayString)!
    saveData.numberLeft = calculateNumberWithOperand(saveData)
    saveData.firstOper = saveData.SecondOper

    //데이터 포멧을 변경하여 전달
    return StringFormat(saveData.numberLeft)
}

func calculateCore(_ currentDisplayString:String,_ inputOperand: String, _ userTypingCheck:Bool) -> String {
    //AC 입력 받은 경우 모든사항 초기화
    if inputOperand == "AC" {
        print("초기화 실행")
        saveData.initializationAll()
        return "0"
    }
    // 첫번째 operand를 받앗을때 처리
    if saveData.firstOper == "" {
        // = 표시를 여러번 누를때 처리
        if inputOperand == "=" {
            print("처음들어온 데이터가 = ")
            return currentDisplayString
        }
        print("데이터가 처음 들어온 경우")
        saveData.numberLeft = Double(currentDisplayString)!
        saveData.firstOper = inputOperand
        print(saveData)
    } else if userTypingCheck == false && inputOperand != "=" {
        print("연산자만 바뀌는 경우 방지")
        print(saveData)
        saveData.firstOper = inputOperand
    } else { // 두번째 operand를 받았을때 처리
        //두번째 number 및 operand 저장
        print("데이터가 두번째 들어온 경우 // numberRight있음")
        if saveData.firstOper == "=" {
            saveData.numberLeft = Double(currentDisplayString)!
            saveData.SecondOper = saveData.firstOper
        }
        print(saveData)
        if let number = Double(currentDisplayString) {
            print("정상")
            saveData.numberRight = number
        } else {
            print("에러")
            saveData.numberRight = saveData.numberLeft
        }
        saveData.SecondOper = inputOperand
      
        // 계산이 실제로 이루어지는 곳
        saveData.numberLeft = calculateNumberWithOperand(saveData)
        saveData.firstOper = saveData.SecondOper
        print(saveData.numberLeft)
        print(saveData)
        //데이터 포멧을 변경하여 전달
        return StringFormat(saveData.numberLeft)
    }
    return currentDisplayString
}


func calculateNumberWithOperand(_ saveData:operandStruct) -> Double {
    var getSaveData = saveData
    switch getSaveData.firstOper {
    case "+": return getSaveData.numberLeft + getSaveData.numberRight
    case "−": return getSaveData.numberLeft - getSaveData.numberRight
    case "×": return getSaveData.numberLeft * getSaveData.numberRight
    case "÷": return getSaveData.numberLeft / getSaveData.numberRight
    case "=": let temp = getSaveData.numberLeft; getSaveData.initailzationSecondValue(); return temp
    default: print("Error")
    }
    return 0.0
}

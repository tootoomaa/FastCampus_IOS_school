//
//  CalculateMainViewController.swift
//  CalculateCoding
//
//  Created by 김광수 on 2020/05/21.
//  Copyright © 2020 김광수. All rights reserved.
//

private var checkUserTyping:Bool = false

func handleInputButtonText(_ inputButtonText:String,_ currentDisplayString:String) -> String {
    print("tabButton : inputButton \(inputButtonText), CDS : \(currentDisplayString)")
    var returnValue:String = ""
    if Double(inputButtonText) == nil { // 문자 버튼 처리
//        returnValue = calculateCore(currentDisplayString, inputButtonText, checkUserTyping)
        returnValue = newCalculaeCore(currentDisplayString, inputButtonText, checkUserTyping)
        checkUserTyping = false
        return returnValue
    } else { // 숫자 버튼 처리
        if !checkUserTyping {   // 처음 입력을 시작함
            checkUserTyping = true
            return inputButtonText == "0" ? "0" : inputButtonText
        } else {                // 숫자를 추가하는 경우
            if(currentDisplayString.count < 13) {
                return currentDisplayString + inputButtonText
            }
            else {
                return currentDisplayString
            }
        }
    }
}

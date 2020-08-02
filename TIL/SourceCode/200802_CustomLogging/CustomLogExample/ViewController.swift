//
//  ViewController.swift
//  CustomLogExample
//
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  private let dog = Dog()
  private let cat = Cat()
  
  override var description: String {
    return "ViewController!!!"
  }
  
  override var debugDescription: String {
    return "debug in ViewController!!!"
  }
  
  @IBAction private func didTapPrint(_ sender: Any) {
    print("\n---------- [ print ] ----------\n")
    print("Hello, world!")
    print(1...10)
    print(dog)
    print(cat)
    print(self)
  }
  
  @IBAction private func didTapDebugPrint(_ sender: Any) {
    print("\n---------- [ debugPrint ] ----------\n")
    debugPrint("Hello, world!")
    debugPrint(1...10)
    debugPrint(dog)
    debugPrint(cat)
    debugPrint(self)
  }
  
  @IBAction private func didTapDump(_ sender: Any) {
    print("\n---------- [ dump ] ----------\n")
    dump("Hello, world!")
    dump(1...10)
    dump(dog)
    dump(cat)
    dump(self)
  }
  
  @IBAction private func didTapNSLog(_ sender: Any) {
    print("\n---------- [ NSLog ] ----------\n")
    NSLog("Hello, world!")
    NSLog("%@", self)
    
    NSLog("%@", dog)
    NSLog("%@", cat.description)
  }
  
  @IBAction private func didTapSpecialLiterals(_ sender: Any) {
    print("\n---------- [ didTapSpecialLiterals ] ----------\n")
    /*
     #file : (String) 파일 이름
     #function : (String) 함수 이름
     #line : (Int) 라인 넘버
     #culumn : (Int) 컬럼 넘버
     */
    print("file :", #file)
    print("function: ", #function)
    print("line: ", #line)
    print("column: ", #column)
    
    print("\n --------- [ print Info ] --------------\n")
    print("< \(#function) [\(#line)] > \(cat) ")
    
  }
  
  @IBAction private func didTapCustomLog(_ sender: Any) {
    print("\n---------- [ Custom Log ] ----------\n")
    
    logger("Hello, world!", header: "String")
    logger(dog, header: "Dog")
    logger(cat, header: "Cat")
    logger(self, header: "ViewController")
  }
  
  @IBAction private func didTapTestButton(_ sender: Any) {
    print("\n---------- [ Test ] ----------\n")
    // 테스트용 버튼
  }
}




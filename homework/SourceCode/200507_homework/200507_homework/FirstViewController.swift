//
//  ViewController.swift
//  200507_homework
//
//  Created by 김광수 on 2020/05/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    // 변수 변경시 레이블 자동 변경 코드 추가
    var dogCount:Int = 0 {
        didSet {
            dogCountLabel.text = String(dogCount)
        }
    }
    var catCount:Int = 0 {
        didSet {
            catCountLabel.text = String(catCount)
        }
    }
    var birdCount:Int = 0 {
        didSet {
            birdCountLabel.text = String(birdCount)
        }
    }
    
    // 사용자가 선택한 동물의 이름 저장
    var selectedAnimal:String = ""
    
    //SecondViewController에서 "Add ALL"버튼이 눌려진 횟수 가져옴
    var getplusButtonTabCount:Int = 0
    
    @IBOutlet weak var dogCountLabel: UILabel!
    @IBOutlet weak var catCountLabel: UILabel!
    @IBOutlet weak var birdCountLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 화면 이동이 발생한 경우 실행되는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // SecondVC의 VC 변수 생성
        guard let secondVC = segue.destination as? SecondViewController else {return}
        // segue의 identifier 값 추출
        guard let identifier = segue.identifier else {return}
        secondVC.getSelectedAnimal = identifier
    }
    
    // 눌려진 버튼의 횟수에 따라서 segue를 실행 여부를 정하는 함수
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Dog" && dogCount < 7 {
            return true
        } else if identifier == "Cat" && catCount < 9 {
            return true
        } else if identifier == "Bird" && birdCount < 14 {
            return true
        }
        
        return false
    }
    
    @IBAction func tabAnimalButton(_ sender: UIButton) {
        // 버튼 클릭시 전달할 데이터 생성
        guard let animal = sender.currentTitle else {return}
        if animal == "Dog" {
            dogCount += 1
        } else if animal == "Cat" {
            catCount += 1
        } else if animal == "Bird" {
            birdCount += 1
        }
        selectedAnimal = animal
    }
    
    // secondVC에서 되돌아올때 실행할 함수, SecondVC에 있는 전체 횟수를 늘리는 버튼이 눌려진 횟수 추출
    @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) {
        guard let secondVC = unwindSegue.source as? SecondViewController else {return}
        getplusButtonTabCount = secondVC.plusButtonTabCount
        dogCount += getplusButtonTabCount
        catCount += getplusButtonTabCount
        birdCount += getplusButtonTabCount
    }
    @IBAction func tabResetButton(_ sender: Any) {
        catCount = 0
        dogCount = 0
        birdCount = 0
    }
}

